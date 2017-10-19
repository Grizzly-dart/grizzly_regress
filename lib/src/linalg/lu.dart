import 'package:grizzly_series/grizzly_series.dart';

LU lu(Numeric2D matrix) => new LU.compute(matrix);

Double2D solve(Numeric2D a, Numeric2D b) =>
    new LU.compute(a).solve(b);

/// The lower-upper factor decomposition of a [Matrix], with partial pivoting.
///
/// Lower-upper factor decomposition with partial pivoting of an M x N matrix
/// `A`, results in 3 matrices:
///
/// - `L`: the lower factor matrix. An M x N [Matrix] with all zero's above the
///   diagonal.
/// - `U`: the upper factor matrix. An N x N [Matrix] with all zero's below the
///   diagonal.
/// - `P`: the pivot matrix. An M x M permutation [Matrix].
///
/// Such that `PA = LU`.
///
/// The primary use of the lower-upper decomposition is in the solution of
/// square systems of simultaneous linear equations. This will fail if the
/// [Matrix] is non-singular. Pivoting reduces the impact of rounding errors.
class LU {
  /// The source [Matrix].
  ///
  /// The [Matrix] for which this is the [PivotingLUDecomposition].
  // TODO final Matrix matrix;

  /// LU decomposition values.
  final Double2D lu;

  /// The pivot vector.
  ///
  /// Used to keep track of where to place 1's in the pivot matrix.
  ///
  /// Each row in the pivot matrix consists of zero's and one 1. The values
  /// in the pivot vector track in which column to place the one (zero indexed).
  /// A pivot vector of `(0, 2, 3, 1)` thus corresponds to the following pivot
  /// matrix:
  ///
  ///     1 0 0 0
  ///     0 0 1 0
  ///     0 0 0 1
  ///     0 1 0 0
  ///
  final Int1D piv;

  /// The pivot sign.
  final num pivotSign;

  LU(this.lu, this.piv, this.pivotSign);

  /// Creates a new [PivotingLUDecomposition] for the [matrix].
  factory LU.compute(Numeric2D matrix) {
    final lu = new Double2D.fromNum(matrix);
    final int numRows = matrix.numRows;
    final int numCols = matrix.numCols;
    int pivotSign = 1;
    final piv = new Int1D(new List<int>.generate(numRows, (i) => i));

    // Outer loop.
    for (var j = 0; j < numCols; j++) {
      // Find pivot
      int p = j;

      for (var i = j + 1; i < numRows; i++) {
        if (lu[i][j].abs() > lu[p][j].abs()) {
          p = i;
        }
      }

      // Exchange pivot if necessary
      if (p != j) {
        for (var k = 0; k < numCols; k++) {
          final double t = lu[p][k];
          lu[p][k] = lu[j][k];
          lu[j][k] = t;
        }

        final int k = piv[p];
        piv[p] = piv[j];
        piv[j] = k;

        pivotSign = -pivotSign;
      }

      // Compute multipliers.
      if (j < numRows && lu[j][j] != 0.0) {
        for (var i = j + 1; i < numRows; i++) {
          lu[i][j] /= lu[j][j];

          for (var k = j + 1; k < numCols; k++) {
            lu[i][k] -= lu[i][j] * lu[j][k];
          }
        }
      }
    }

    return new LU(lu, piv, pivotSign);
  }

  /// Whether is not the decomposed [Matrix] is non-singular.
  ///
  /// A non-singular [Matrix] has an inverse and a non-zero determinant.
  ///
  /// Throws an [UnsupportedError] if the decomposed [Matrix] is not square.
  bool get isNonSingular {
    if (!lu.isSquare) {
      throw new UnsupportedError('Matrix is not square.');
    }

    for (var j = 0; j < lu.numCols; j++) {
      if (lu[j][j] == 0.0) return false;
    }

    return true;
  }

  /// This [PivotingLUDecomposition]'s lower factor.
  ///
  /// A [Matrix] with all zero's above the diagonal.
  Double2D get lowerFactor {
    final values = new Double2D.shapedLike(lu);

    for (int i = 0; i < lu.numRows; i++) {
      for (int j = 0; j < lu.numCols; j++) {
        if (i > j) {
          values[i][j] = lu[i][j];
        } else if (i == j) {
          values[i][j] = 1.0;
        }
      }
    }

    return values;
  }

  /// This [PivotingLUDecomposition]'s upper factor.
  ///
  /// A [Matrix] with all zero's below the diagonal.
  Double2D get upperFactor {
    final values = new Double2D.sized(lu.numCols, lu.numCols);

    for (int i = 0; i < lu.numCols; i++) {
      for (int j = 0; j < lu.numCols; j++) {
        if (i <= j) {
          values[i][j] = lu[i][j];
        }
      }
    }

    return values;
  }

  /// This [PivotingLUDecomposition]'s pivot matrix.
  ///
  /// A permutation matrix.
  Double2D get pivotMatrix {
    final values = new Double2D.sized(lu.numRows, lu.numRows);

    for (var i = 0; i < lu.numRows; i++) {
      for (var j = 0; j < lu.numRows; j++) {
        if (j == piv[i]) {
          values[i][j] = 1.0;
        }
      }
    }

    return values;
  }

  /// The decomposed [Matrix]'s determinant.
  ///
  /// Throws an [UnsupportedError] if the decomposed [Matrix] is not square.
  double get determinant {
    if (!lu.isSquare) {
      throw new UnsupportedError('Matrix must be square.');
    }

    double determinant = pivotSign.toDouble();

    for (int j = 0; j < lu.numCols; j++) {
      determinant *= lu[j][j];
    }

    return determinant;
  }

  /// Solves `AX=B` for X, where `A` is the decomposed [Matrix] and [b] the
  /// given [Matrix].
  ///
  /// Throws an [ArgumentError] if the row dimensions of `A` and [b] do not
  /// match.
  ///
  /// Throws an [UnsupportedError] if `A` is not square.
  ///
  /// Throws an [UnsupportedError] if `A` is singular (not invertible).
  Double2D solve(Numeric2D b) {
    if (b.numRows != lu.numRows) {
      throw new ArgumentError('Matrix row dimensions must agree.');
    }

    if (!isNonSingular) {
      throw new UnsupportedError('Matrix is singular.');
    }

    final bVals = array2D(b);
    final xCols = b.numCols;
    final xVals = new Double2D.sized(lu.numCols, xCols);

    // Copy right hand side with pivoting
    for (int row in piv) {
      for (int i = 0; i < xCols; i++) {
        xVals[row][i] = bVals[row][i];
      }
    }

    // Solve L*Y = B(piv,:)
    for (var k = 0; k < lu.numCols; k++) {
      for (var i = k + 1; i < lu.numCols; i++) {
        for (var j = 0; j < xCols; j++) {
          xVals[i][j] -= xVals[k][j] * lu[i][k];
        }
      }
    }

    // Solve U*X = Y;
    for (var k = lu.numCols - 1; k >= 0; k--) {
      for (var j = 0; j < xCols; j++) {
        xVals[k][j] /= lu[k][k];
      }

      for (var i = 0; i < k; i++) {
        for (var j = 0; j < xCols; j++) {
          xVals[i][j] -= xVals[k][j] * lu[i][k];
        }
      }
    }

    return xVals;
  }
}
