// Copyright (c) 2017, SERAGUD. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// import 'dart:typed_data';
import 'dart:math';
import 'package:grizzly_series/grizzly_series.dart';

QR qr(Numeric2D matrix) => new QR.compute(matrix);

/// The reduced QR-decomposition of a matrix.
///
/// Decomposes an M x N matrix `A`, with `M >= N`, into an M x N orthogonal
/// matrix `Q` and an N x N upper rectangular matrix `R`, such that
/// `A = QR`.
///
/// The primary use of the reduced QR-decomposition is in the least squares
/// solution of non-square systems of simultaneous linear equations. This will
/// fail if the matrix is rank deficient.
class QR {
  /// QR decomposition values.
  final Double2D qr;

  /// The values on the diagonal of the upper rectangular factor.
  final Double1D rDiag;

  final Double2D q;

  final Double2D r;

  QR(this.qr, this.rDiag): q = QR.orthogonalFactor(qr), r = QR.upperTriangularFactor(qr, rDiag);

  /// Creates a new [ReducedQRDecomposition] for the [matrix].
  factory QR.compute(Numeric2D matrix) {
    final qr = new Double2D.fromNum(matrix);
    final rDiag = new Double1D.sized(matrix.numCols);

    final int numRows = matrix.numRows;
    final int numCols = matrix.numCols;

    // Main loop.
    for (int k = 0; k < numCols; k++) {
      // Compute 2-norm of k-th column
      double nrm = 0.0;

      for (int r = k; r < numRows; r++) {
        nrm = sqrt(pow(nrm, 2) + pow(qr[r][k], 2));
      }

      if (nrm != 0.0) {
        // Form k-th Householder vector.
        if (qr[k][k] < 0) {
          nrm = -nrm;
        }

        for (int r = k; r < numRows; r++) {
          qr[r][k] /= nrm;
        }

        qr[k][k] += 1.0;

        // Apply transformation to remaining columns.
        for (int j = k + 1; j < numCols; j++) {
          double s = 0.0;

          for (int i = k; i < numRows; i++) {
            s += qr[i][k] * qr[i][j];
          }

          s = -s / qr[k][k];

          for (int i = k; i < numRows; i++) {
            qr[i][j] += s * qr[i][k];
          }
        }
      }

      rDiag[k] = -nrm;
    }

    return new QR(qr, rDiag);
  }

  /// This [ReducedQRDecomposition]'s Householder matrix.
  ///
  /// Lower trapezoidal [Matrix] whose columns define the reflections.
  static Double2D householderMatrix(Double2D qr) {
    final Index2D shape = qr.shape;
    final values = new Double2D.shaped(shape);

    for (int i = 0; i < shape.row; i++) {
      for (int j = 0; j < shape.column; j++) {
        if (i >= j) {
          values[i][j] = qr[i][j];
        } else {
          values[i][j] = 0.0;
        }
      }
    }

    return values;
  }

  /// Computes and returns the upper triangular factor R.
  static Double2D upperTriangularFactor(Double2D qr, Double1D rDiag) {
    final int numCols = qr.shape.column;
    final values = new Double2D.sized(qr.shape.column, qr.shape.column);

    for (int i = 0; i < numCols; i++) {
      for (int j = 0; j < numCols; j++) {
        if (i < j) {
          values[i][j] = qr[i][j];
        } else if (i == j) {
          values[i][j] = rDiag[i];
        } else {
          values[i][j] = 0.0;
        }
      }
    }

    return values;
  }

  /// Computes and returns the orthogonal factor Q.
  static Double2D orthogonalFactor(Double2D qr) {
    final Index2D shape = qr.shape;

    final values = new Double2D.shaped(qr.shape);

    for (int k = shape.column - 1; k >= 0; k--) {
      for (int i = 0; i < shape.row; i++) {
        values[i][k] = 0.0;
      }

      if (k < shape.row) {
        values[k][k] = 1.0;
      }

      for (int j = k; j < shape.column; j++) {
        if (k < shape.row && qr[k][k] != 0.0) {
          double s = 0.0;

          for (int i = k; i < shape.row; i++) {
            s += qr[i][k] * values[i][j];
          }

          s = -s / qr[k][k];

          for (int i = k; i < shape.row; i++) {
            values[i][j] += s * qr[i][k];
          }
        }
      }
    }

    return values;
  }

  /// Whether or not the decomposed [Matrix] is full rank.
  bool get isFullRank {
    for (int j = 0; j < qr.numCols; j++) {
      if (rDiag[j].abs() < 0.00001) {
        return false;
      }
    }

    return true;
  }

  Double2D solve(Double2D b) {
    if (b.numRows != qr.numRows) {
      throw new ArgumentError('Matrix row dimensions must agree.');
    }

    if (!isFullRank) {
      throw new UnsupportedError('Matrix is rank deficient.');
    }

    // Copy right hand side
    final xCols = b.numCols;
    final xVals = new Double2D(b);

    // Compute Y = transpose(Q)*B
    for (int k = 0; k < qr.numCols; k++) {
      for (int j = 0; j < xCols; j++) {
        double s = 0.0;

        for (int i = k; i < qr.numRows; i++) {
          s += qr[i][k] * xVals[i][j];
        }

        s = -s / qr[k][k];

        for (int i = k; i < qr.numRows; i++) {
          xVals[i][j] += s * qr[i][k];
        }
      }
    }

    // Solve R*X = Y;
    for (int k = qr.numCols - 1; k >= 0; k--) {
      for (int j = 0; j < xCols; j++) {
        xVals[k][j] /= rDiag[k];
      }

      for (int i = 0; i < k; i++) {
        for (int j = 0; j < xCols; j++) {
          xVals[i][j] -= xVals[k][j] * qr[i][k];
        }
      }
    }

    return xVals.slice(idx2D(0, 0), idx2D(qr.numCols, xCols));
  }
}
