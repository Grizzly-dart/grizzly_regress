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
  RegressionResult fit(Iterable<num> x, Iterable<num> y,
      {bool fitIntercept: false}) {
    Double2D actualX = x.toDouble().toCol();

    Double2D procX = actualX.clone();
    if (fitIntercept) procX.cols.addScalar(1.0);

    final SVD xSvd = svd(procX);

    final Double2D pinv = xSvd.pinv();

    final Double1D coeff = pinv.matmul(y.toCol().toDouble()).cols[0];
    final Double2D cov = pinv.matmul(pinv.transpose);

    return RegressionResult(coeff,
        x: actualX,
        y: y.toList(),
        normalizedCovParams: cov,
        interceptFitted: fitIntercept,
        rank: xSvd.rank());
  }

  @override
  RegressionResult fitMultivariate(Num2D x, Iterable<num> y,
      {bool fitIntercept: false}) {
    Double2D actualX = x.toDouble();

    Double2D procX = actualX.clone();
    if (fitIntercept) procX.cols.addScalar(1.0);

    final SVD xSvd = svd(procX);

    final Double2D pinv = xSvd.pinv();

    final Iterable<double> coeff = pinv.matmul(y.toCol().toDouble()).cols[0];
    final Double2D cov = pinv.matmul(pinv.transpose);

    return RegressionResult(coeff,
        x: actualX,
        y: y.toList(),
        normalizedCovParams: cov,
        interceptFitted: fitIntercept,
        rank: xSvd.rank());
  }

  /// Fit simple model with one independent variable
  List<RegressionResult> fitMany(Iterable<num> x, Num2DView y,
      {bool fitIntercept: false}) {
    Double2D actualX = x.toDouble().toCol();
    y = y.toList2D();

    Double2D procX = actualX.clone();
    if (fitIntercept) procX.cols.addScalar(1.0);

    final SVD xSvd = svd(procX);

    final Double2D pinv = xSvd.pinv();

    final Double2D coeff = pinv.matmul(y.toList2D());
    final Double2D cov = pinv.matmul(pinv.transpose);

    return y.cols
        .mapIndexed((i, e) => RegressionResult(coeff.cols[i],
            x: actualX,
            y: y.cols[i],
            normalizedCovParams: cov,
            interceptFitted: fitIntercept,
            rank: xSvd.rank()))
        .toList();
  }

  /// Fit model with multiple independent variable
  List<RegressionResult> fitManyMultivariate(Num2DView x, Num2DView y,
      {bool fitIntercept: false}) {
    Double2D actualX = x.toDouble();
    y = y.toList2D();

    Double2D procX = actualX.clone();
    if (fitIntercept) procX.cols.addScalar(1.0);

    final SVD xSvd = svd(procX);

    final Double2D pinv = xSvd.pinv();

    final Double2D coeff = pinv.matmul(y.toList2D());
    final Double2D cov = pinv.matmul(pinv.transpose);

    return y.cols
        .mapIndexed((i, e) => RegressionResult(coeff.cols[i],
        x: actualX,
        y: y.cols[i],
        normalizedCovParams: cov,
        interceptFitted: fitIntercept,
        rank: xSvd.rank()))
        .toList();
  }
}

/*
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
    return RegressionResult(coeff,
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
      return RegressionResult(coeff,
          x: tempX, y: y, covariance: covMatrix, interceptFitted: fitIntercept);
    } else {
      final Double2D effects = xQR.q.transpose * y.transpose;
      final coeff = solve(xQR.r, effects).col[0];
      // TODO x, y must be copied views
      return RegressionResult(coeff,
          x: tempX, y: y, covariance: covMatrix, interceptFitted: fitIntercept);
    }
  }

  /// Fit simple model with one independent variable
  RegressionResult fitOneMultivariate(Numeric1D x, Numeric2D y) {
    // TODO
    throw UnimplementedError();
  }

  /// Fit model with multiple independent variable
  RegressionResult fitMultivariate(Numeric2D x, Numeric2D y) {
    // TODO
    throw UnimplementedError();
  }
}
*/
