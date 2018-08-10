part of grizzly.regress;

/// Mixin for regression model
abstract class RegressionModel {
  /// Estimated coefficients for the linear regression problem
  Double1DFix get coeff;

  /// Is the intercept induced by the model?
  bool get interceptFitted;

  /// Independent term in the linear model
  double get intercept {
    if (interceptFitted) {
      return coeff.last;
    } else {
      return 0.0;
    }
  }

  /// Predicts y_hat for given single independent variable sample [x] and
  /// coefficient [coeff]
  double predictOne(Numeric1DView x) {
    if (interceptFitted) {
      if ((x.length + 1) != coeff.length)
        throw new ArgumentError.value(
            "Have ${coeff.length} coefficients (with intercept fitted). But number of exogeneous variables is ${x.length}. ${coeff.length - 1} exogenous variables expected!");

      double ret = coeff.last;

      ret += coeff.slice(0, coeff.length - 1).dot(x); // TODO use sliceView

      return ret;
    } else {
      if (x.length != coeff.length)
        throw new ArgumentError(
            "Have ${coeff.length} coefficients. But number of exogeneous variables is ${x.length}! ${coeff.length} exogenous variables expected!");

      return coeff.dot(x);
    }
  }

  /// Predicts y_hat for given multiple independent variable samples [x] and
  /// coefficient [coeff]
  Double1D predict(Numeric2DView x) {
    final ret = new Double1D.sized(x.numRows);
    for (int i = 0; i < x.numRows; i++) {
      ret[i] = predictOne(x[i]);
    }
    return ret;
  }
}
