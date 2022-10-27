part of grizzly.regress;

/// Ordinary least square regression performed using stochastic gradient descent
class OLS_SGD implements LinearRegression {
  const OLS_SGD();

  /// Fit simple model with one independent variable
  RegressionResult fit(Num1DView x, Num1DView y, {bool fitIntercept: false}) {
    // TODO
    throw UnimplementedError();
  }

  /// Fit model with multiple independent variable
  RegressionResult fitMultivariate(Num2DView x, Num1DView y,
      {bool fitIntercept: false}) {
    throw UnimplementedError();
  }

  /// Fit simple model with one independent variable
  List<RegressionResult> fitMany(Iterable<num> x, Num2DView y,
      {bool fitIntercept: false}) {
    throw UnimplementedError();
  }

  /// Fit model with multiple independent variable
  List<RegressionResult> fitManyMultivariate(Num2DView x, Num2DView y,
      {bool fitIntercept: false}) {
    throw UnimplementedError();
  }
}

/// Ordinary least square regression performed using gradient descent
class OLS_GD implements LinearRegression {
  /// Learning rate used in gradient descent
  final double learningRate;

  /// Maximum iterations
  final int maxIterations;

  const OLS_GD({this.learningRate: 1e-4, this.maxIterations: 10000});

  /// Performs a simple linear regression fit
  RegressionResult fit(Num1DView x, Num1DView y, {bool fitIntercept: false}) =>
      fitMultivariate(x.toCol(), y, fitIntercept: fitIntercept);

  RegressionResult fitMultivariate(Num2DView x, Num1DView y,
      {bool fitIntercept: false}) {
    Double2D tempX = x.toDouble();
    Num1D tempY = y.toList();

    if (fitIntercept) tempX.cols.addScalar(1.0);

    final gd = BatchLeastSquareGradientDescent(tempX, tempY,
        learningRate: learningRate, maxIterations: maxIterations);
    gd.learn();
    return RegressionResult(
      gd.params,
      x: tempX,
      y: tempY,
      normalizedCovParams: [], // TODO
      interceptFitted: fitIntercept,
      rank: 1, // TODO
    );
  }

  /// Fit simple model with one independent variable
  List<RegressionResult> fitMany(Iterable<num> x, Num2DView y,
      {bool fitIntercept: false}) {
    throw UnimplementedError();
  }

  /// Fit model with multiple independent variable
  List<RegressionResult> fitManyMultivariate(Num2DView x, Num2DView y,
      {bool fitIntercept: false}) {
    throw UnimplementedError();
  }
}
