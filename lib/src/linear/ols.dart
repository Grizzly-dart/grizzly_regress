part of grizzly.regress;

/// Convenient way to use OLS regression
///
///     final x = array2D([
///       [1, 1, 2],
///       [1, 2, 3],
///       [1, 3, 4],
///       [1, 4, 5],
///       [1, 5, 6],
///     ]);
///     final y = (x * [7, 5, 2]).sumCol;
///     final RegressionResult res = ols.fitMultipleX(x, y, fitIntercept: true);
///     print(res.coeff); // => (-7.501368540301152, -9.501368540301195, 16.50136854030119)
///     print(res.predict(x[0].toInt())); // => 16.000000000000036
///
const OLS ols = const OLS();

/// Linear Regression
abstract class LinearRegression implements Regression {
  factory LinearRegression() => const OLS();

  static const OLS ols = const OLS();
}

/// Ordinary Least Square regression performed by directly solving `XB=Y`
///
/// Solves `XB=Y`, where X is exogenous variables, Y is endogenous variable and
/// B are the model parameters to be found.
///
/// Uses QR decomposition to solve `XB=Y` when X is full rank.
/// Uses LU decomposition to solve `XB=Y` when X is not full rank.
class OLS implements LinearRegression {
  const OLS();

  RegressionResult fit(Numeric1D x, Numeric1D y,
      {bool fitIntercept: false}) {
    Numeric2D tempX = x.transpose;
    if (fitIntercept) {
      tempX = x.toDouble.to2D();
      tempX.col.addScalar(1.0);
    }
    final QR xQR = qr(tempX);
    // TODO normalize covMatrix
    final Double2D covMatrix = xQR.r.transpose * xQR.r;
    final coeff = xQR.solve(y.transpose).col[0];

    // TODO x, y must be copied views
    return new RegressionResult(coeff, x: tempX, y: y,
        covMatrix: covMatrix, interceptFitted: fitIntercept);
  }

  RegressionResult fitMultipleX(Numeric2D x, Numeric1DView y,
      {bool fitIntercept: false}) {
    Numeric2D tempX = x;
    if (fitIntercept) {
      tempX = x.toDouble;
      tempX.col.insertScalar(0, 1.0);
    }
    final QR xQR = qr(tempX);
    // TODO normalize covMatrix
    final Double2D covMatrix = xQR.r.transpose * xQR.r;

    if (xQR.isFullRank) {
      final coeff = xQR.solve(y.transpose).col[0];
      // TODO x, y must be copied views
      return new RegressionResult(coeff, x: tempX, y: y,
          covMatrix: covMatrix, interceptFitted: fitIntercept);
    } else {
      final Double2D effects = xQR.q.transpose * y.transpose;
      final coeff = solve(xQR.r, effects).col[0];
      // TODO x, y must be copied views
      return new RegressionResult(coeff, x: tempX, y: y,
          covMatrix: covMatrix, interceptFitted: fitIntercept);
    }
  }
}

/// Ordinary least square regression performed using gradient descent
class OLSGD implements LinearRegression {
  const OLSGD();

  RegressionResult fit(Numeric1D x, Numeric1D y,
      {bool fitIntercept: false}) {
    // TODO
  }

  RegressionResult fitMultipleX(Numeric2D x, Numeric1D y,
      {bool fitIntercept: false}) {
    // TODO
  }
}

/// Ordinary least square regression performed using stochastic gradient descent
class OLSStochasticGD implements LinearRegression {
  const OLSStochasticGD();

  RegressionResult fit(Numeric1D x, Numeric1D y,
      {bool fitIntercept: false}) {
    // TODO
  }

  RegressionResult fitMultipleX(Numeric2D x, Numeric1D y,
      {bool fitIntercept: false}) {
    // TODO
  }
}
