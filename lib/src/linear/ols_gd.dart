part of grizzly.regress;

/// Ordinary least square regression performed using stochastic gradient descent
class SGDRegressor implements LinearRegressor {
  /// Learning rate used in gradient descent
  final double learningRate;

  /// Maximum iterations
  final int maxIterations;

  final LeastSquareRegularizer? regularizer;

  const SGDRegressor(
      {this.learningRate: 1e-2, this.maxIterations: 10000, this.regularizer});

  /// Fit simple model with one independent variable
  SGDResult fit(Num1DView x, Num1DView y, {bool fitIntercept: false}) =>
      fitMultivariate(x.toCol(), y, fitIntercept: fitIntercept);

  /// Fit model with multiple independent variable
  SGDResult fitMultivariate(Num2DView x, Num1DView y,
      {bool fitIntercept: false, Num1DView? initCoeff}) {
    Double2D tempX = x.toDouble();
    Num1D tempY = y.toList();

    if (fitIntercept) tempX.cols.addScalar(1.0);

    final gd = LeastSquareSGD(tempX, tempY,
        learningRate: learningRate,
        maxIterations: maxIterations,
        regularizer: regularizer,
        initCoeff: initCoeff);
    gd.learn();

    return SGDResult(gd.coeff,
        x: tempX, y: tempY, interceptFitted: fitIntercept);
  }

  /// Fit simple model with one independent variable
  List<SGDResult> fitMany(Num1DView x, Num2DView y,
          {bool fitIntercept: false}) =>
      fitManyMultivariate(x.toCol(), y, fitIntercept: fitIntercept);

  /// Fit model with multiple independent variable
  List<SGDResult> fitManyMultivariate(Num2DView x, Num2DView y,
          {bool fitIntercept: false}) =>
      y.cols
          .map((e) => fitMultivariate(x, e, fitIntercept: fitIntercept))
          .toList();
}

/// Ordinary least square regression performed using gradient descent
class GDRegressor implements LinearRegressor {
  /// Learning rate used in gradient descent
  final double learningRate;

  /// Maximum iterations
  final int maxIterations;

  final LeastSquareRegularizer? regularizer;

  const GDRegressor(
      {this.learningRate: 1e-4, this.maxIterations: 10000, this.regularizer});

  /// Fit simple model with one independent variable
  SGDResult fit(Num1DView x, Num1DView y, {bool fitIntercept: false}) =>
      fitMultivariate(x.toCol(), y, fitIntercept: fitIntercept);

  SGDResult fitMultivariate(Num2DView x, Num1DView y,
      {bool fitIntercept: false, Num1DView? initCoeff}) {
    Double2D tempX = x.toDouble();
    Num1D tempY = y.toList();

    if (fitIntercept) tempX.cols.addScalar(1.0);

    final gd = LeastSquareBGD(tempX, tempY,
        learningRate: learningRate,
        maxIterations: maxIterations,
        initCoeff: initCoeff,
        regularizer: regularizer);
    gd.learn();

    return SGDResult(gd.coeff,
        x: tempX, y: tempY, interceptFitted: fitIntercept);
  }

  /// Fit simple model with one independent variable
  List<SGDResult> fitMany(Num1DView x, Num2DView y,
          {bool fitIntercept: false}) =>
      fitManyMultivariate(x.toCol(), y, fitIntercept: fitIntercept);

  /// Fit model with multiple independent variable
  List<SGDResult> fitManyMultivariate(Num2DView x, Num2DView y,
          {bool fitIntercept: false}) =>
      y.cols
          .map((e) => fitMultivariate(x, e, fitIntercept: fitIntercept))
          .toList();
}
