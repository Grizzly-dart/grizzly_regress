part of grizzly.regress;

/// Linear Regression
abstract class LinearRegressor {
  factory LinearRegressor() = Ols;

  /// Fit simple model with one independent variable
  RegressionModel fit(Num1DView x, Num1DView y, {bool fitIntercept: false}) =>
      fitMultivariate(x.toCol(), y, fitIntercept: fitIntercept);

  /// Fit model with multiple independent variable
  RegressionModel fitMultivariate(Num2DView x, Num1DView y,
      {bool fitIntercept: false});

  /// Fit simple model with one independent variable
  List<RegressionModel> fitMany(Num1DView x, Num2DView y,
          {bool fitIntercept: false}) =>
      fitManyMultivariate(x.toCol(), y, fitIntercept: fitIntercept);

  /// Fit model with multiple independent variable
  List<RegressionModel> fitManyMultivariate(Num2DView x, Num2DView y,
          {bool fitIntercept: false}) =>
      y.cols
          .map((e) => fitMultivariate(x, e, fitIntercept: fitIntercept))
          .toList();

  static const Ols ols = const Ols();
}
