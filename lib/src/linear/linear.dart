part of grizzly.regress;

/// Linear Regression
abstract class LinearRegression implements Regression {
  factory LinearRegression() => const OLS();

  static const OLS ols = const OLS();
}

