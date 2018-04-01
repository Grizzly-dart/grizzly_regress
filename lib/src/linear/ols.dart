part of grizzly.regress;

/// Ordinary Least Square regression performed by directly solving 'X * B = Y'.
///
///     final x = array2D([
///       [1, 1, 2],
///       [1, 2, 3],
///       [1, 3, 4],
///       [1, 4, 5],
///       [1, 5, 6],
///     ]);
///     final y = (x * [7, 5, 2]).sumCol;
///     final RegressionResult res = ols.fitMultipleX(x, y);
///     print(res.coeff); // => (-7.501368540301152, -9.501368540301195, 16.50136854030119)
///     print(res.predict(x[0].toInt())); // => 16.000000000000036
const OLS ols = const OLS();

/// Ordinary Least Square regression performed by directly solving 'X * B = Y'.
///
/// Uses QR decomposition to solve 'XB=Y' when X is full rank.
/// Uses LU decomposition to solve 'XB=Y' when X is not full rank.
class OLS implements LinearRegression {
  const OLS();

  RegressionResult fit(Numeric1DView x, Numeric1DView y,
      {bool fitIntercept: false}) {
    Numeric2D<double> procX;
    if (fitIntercept) {
      procX = x.toDouble.to2D();
      procX.col.addScalar(1.0);
    } else {
      procX = x.toDouble.transpose;
    }
    final QR xqr = qr(procX);
    // TODO normalize covMatrix
    final Double2D covMatrix = xqr.r.transpose * xqr.r;
    final Double1DFix coeff = xqr.solve(y.transpose).col[0];

    // TODO x, y must be copied views
    return new RegressionResult(coeff,
        x: procX, y: y, covMatrix: covMatrix, interceptFitted: fitIntercept);
  }

  RegressionResult fitMultipleX(Numeric2D x, Numeric1DView y,
      {bool fitIntercept: false}) {
    Numeric2D tempX = x;
    if (fitIntercept) {
      tempX = x.toDouble();
      tempX.col.insertScalar(0, 1.0);
    }
    final QR xQR = qr(tempX);
    // TODO normalize covMatrix
    final Double2D covMatrix = xQR.r.transpose * xQR.r;

    if (xQR.isFullRank) {
      final coeff = xQR.solve(y.transpose).col[0];
      // TODO x, y must be copied views
      return new RegressionResult(coeff,
          x: tempX, y: y, covMatrix: covMatrix, interceptFitted: fitIntercept);
    } else {
      final Double2D effects = xQR.q.transpose * y.transpose;
      final coeff = solve(xQR.r, effects).col[0];
      // TODO x, y must be copied views
      return new RegressionResult(coeff,
          x: tempX, y: y, covMatrix: covMatrix, interceptFitted: fitIntercept);
    }
  }
}
