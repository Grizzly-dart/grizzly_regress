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
const Ols ols = const Ols();

/// Ordinary Least Square regression performed by directly solving 'X * B = Y'.
///
/// Uses QR decomposition to solve 'XB=Y' when X is full rank.
/// Uses LU decomposition to solve 'XB=Y' when X is not full rank.
class Ols implements LinearRegression {
  const Ols();

  @override
  RegressionResult fitOne(Numeric1DView x, Numeric1DView y,
      {bool fitIntercept: false}) {
    Numeric2D<double> procX;
    if (fitIntercept) {
      procX = x.toDouble.to2D();
      procX.col.addScalar(1.0);
    } else {
      procX = x.toDouble.transpose;
    }

    final SVD xSvd = svd(procX);

    final Double2D pinv = xSvd.pinv();

    final Double1DFix coeff = pinv.matmul(y.transpose).col[0];
    final Double2D cov = pinv.matmul(pinv.transpose);

    // TODO x, y must be copied views
    return new RegressionResult(coeff,
        x: procX,
        y: y,
        covariance: cov,
        interceptFitted: fitIntercept,
        xRank: xSvd.rank());
  }

  @override
  RegressionResult fit(Numeric2D x, Numeric1DView y,
      {bool fitIntercept: false}) {
    Numeric2D tempX = x;
    if (fitIntercept) {
      tempX = x.toDouble();
      tempX.col.addScalar(1.0);
    }
    final QR xQR = qr(tempX);
    // TODO normalize covMatrix
    final Double2D covMatrix = xQR.r.transpose * xQR.r;

    if (xQR.isFullRank) {
      final coeff = xQR.solve(y.transpose).col[0];
      // TODO x, y must be copied views
      return new RegressionResult(coeff,
          x: tempX, y: y, covariance: covMatrix, interceptFitted: fitIntercept);
    } else {
      final Double2D effects = xQR.q.transpose * y.transpose;
      final coeff = solve(xQR.r, effects).col[0];
      // TODO x, y must be copied views
      return new RegressionResult(coeff,
          x: tempX, y: y, covariance: covMatrix, interceptFitted: fitIntercept);
    }
  }

  /// Fit simple model with one independent variable
  RegressionResult fitOneMultivariate(Numeric1D x, Numeric2D y) {
    // TODO
    throw new UnimplementedError();
  }

  /// Fit model with multiple independent variable
  RegressionResult fitMultivariate(Numeric2D x, Numeric2D y) {
    // TODO
    throw new UnimplementedError();
  }
}

/// Ordinary Least Square regression performed by directly solving 'X * B = Y'.
///
/// Uses QR decomposition to solve 'XB=Y' when X is full rank.
/// Uses LU decomposition to solve 'XB=Y' when X is not full rank.
class OlsWithQr implements LinearRegression {
  const OlsWithQr();

  RegressionResult fitOne(Numeric1DView x, Numeric1DView y,
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
        x: procX, y: y, covariance: covMatrix, interceptFitted: fitIntercept);
  }

  RegressionResult fit(Numeric2D x, Numeric1DView y,
      {bool fitIntercept: false}) {
    Numeric2D tempX = x;
    if (fitIntercept) {
      tempX = x.toDouble();
      tempX.col.addScalar(1.0);
    }
    final QR xQR = qr(tempX);
    // TODO normalize covMatrix
    final Double2D covMatrix = xQR.r.transpose * xQR.r;

    if (xQR.isFullRank) {
      final coeff = xQR.solve(y.transpose).col[0];
      // TODO x, y must be copied views
      return new RegressionResult(coeff,
          x: tempX, y: y, covariance: covMatrix, interceptFitted: fitIntercept);
    } else {
      final Double2D effects = xQR.q.transpose * y.transpose;
      final coeff = solve(xQR.r, effects).col[0];
      // TODO x, y must be copied views
      return new RegressionResult(coeff,
          x: tempX, y: y, covariance: covMatrix, interceptFitted: fitIntercept);
    }
  }

  /// Fit simple model with one independent variable
  RegressionResult fitOneMultivariate(Numeric1D x, Numeric2D y) {
    // TODO
    throw new UnimplementedError();
  }

  /// Fit model with multiple independent variable
  RegressionResult fitMultivariate(Numeric2D x, Numeric2D y) {
    // TODO
    throw new UnimplementedError();
  }
}
