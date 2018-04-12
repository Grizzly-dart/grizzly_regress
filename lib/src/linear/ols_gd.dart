part of grizzly.regress;

/* TODO
/// Ordinary least square regression performed using stochastic gradient descent
class OLSStochasticGD implements LinearRegression {
  const OLSStochasticGD();

  RegressionResult fit(Numeric1D x, Numeric1D y, {bool fitIntercept: false}) {
    // TODO
  }

  RegressionResult fitMultipleX(Numeric2D x, Numeric1D y,
      {bool fitIntercept: false}) {
    // TODO
  }
}

/// Ordinary least square regression performed using gradient descent
class OLSGD implements LinearRegression {
  /// Learning rate used in gradient descent
  final double learningRate;

  /// Maximum iterations
  final int maxIterations;

  const OLSGD({this.learningRate: 1e-4, this.maxIterations: 10000});

  /// Performs a simple linear regression fit
  RegressionResult fit(Numeric1D x, Numeric1D y, {bool fitIntercept: false}) {
    // TODO
  }

  RegressionResult fitMultipleX(Numeric2D x, Numeric1DView y,
      {bool fitIntercept: false}) {
    Numeric2D tempX = x;
    if (fitIntercept) {
      tempX = x.toDouble();
      tempX.col.insertScalar(0, 1.0);
    }
    final gd = new BatchLeastSquareGradientDescent(tempX, y,
        learningRate: learningRate, maxIterations: maxIterations);
    gd.learn();
    // TODO x, y must be copied views
    return new RegressionResult(gd.params,
        x: tempX, y: y, interceptFitted: fitIntercept);
  }
}
*/