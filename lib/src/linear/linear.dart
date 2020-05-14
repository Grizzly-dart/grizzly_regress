part of grizzly.regress;

/// Linear Regression
abstract class LinearRegression implements Regression {
  factory LinearRegression() => const Ols();

  static const Ols ols = const Ols();
}
