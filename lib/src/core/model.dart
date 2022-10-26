part of grizzly.regress;

/// Mixin for regression model
abstract class RegressionModel {
  /// Estimated coefficients for the linear regression problem
  Iterable<num> get coeff;

  /// Is the intercept induced by the model?
  bool get interceptFitted;

  /// Independent term in the linear model
  double get intercept {
    if (interceptFitted) {
      return coeff.last.toDouble();
    } else {
      return 0.0;
    }
  }

  /// Predicts y_hat for given single independent variable sample [x] and
  /// coefficient [coeff]
  double predictOne(Iterable<num> x) {
    if (interceptFitted) {
      if ((x.length + 1) != coeff.length)
        throw ArgumentError.value(
            "Have ${coeff.length} coefficients (with intercept fitted). But number of exogeneous variables is ${x.length}. ${coeff.length - 1} exogenous variables expected!");

      double ret = coeff.last.toDouble();

      ret += coeff.cut(0, coeff.length - 1).dot(x);

      return ret;
    } else {
      if (x.length != coeff.length)
        throw ArgumentError(
            "Have ${coeff.length} coefficients. But number of exogeneous variables is ${x.length}! ${coeff.length} exogenous variables expected!");

      return coeff.dot(x).toDouble();
    }
  }

  /// Predicts y_hat for given multiple independent variable samples [x] and
  /// coefficient [coeff]
  Double1D predict(Num2DView x) {
    final ret = Double1D.filled(x.numRows, 0);
    for (int i = 0; i < x.numRows; i++) {
      ret[i] = predictOne(x[i]);
    }
    return ret;
  }
}
