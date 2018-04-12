part of grizzly.regress;

/// Mixin for regression model
abstract class RegressionModel {
  /// Estimated coefficients for the linear regression problem
  Double1DView get coeff;

  /// Is the intercept induced by the model?
  bool get interceptFitted;

  /// Independent term in the linear model
  double get intercept {
    if (interceptFitted) {
      return coeff[0];
    } else {
      return 0.0;
    }
  }

  /// Predicts y_hat for given single independent variable sample [x] and
  /// coefficient [coeff]
  double predict(Numeric1DView x) {
    if (interceptFitted) {
      if ((x.length + 1) != coeff.length)
        throw new ArgumentError.value(x, 'x', 'Invalid independent variables!');

      double ret = coeff[0];

      ret += coeff.slice(1).dot(x); // TODO use sliceView

      return ret;
    } else {
      if (x.length != coeff.length)
        throw new ArgumentError.value(x, 'x', 'Invalid independent variables!');

      return coeff.dot(x);
    }
  }

  /// Predicts y_hat for given multiple independent variable samples [x] and
  /// coefficient [coeff]
  Double1D predictMany(Numeric2DView x) {
    final ret = new Double1D.sized(x.numRows);
    for (int i = 0; i < x.numCols; i++) {
      ret[i] = predict(x.col[i]);
    }
    return ret;
  }
}
