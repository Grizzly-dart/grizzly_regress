part of grizzly.regress;

class MultivariateLinearRegression extends MultivariateLinearModel
    with RegressorMixin {
  LinearRegression fit(NumericArray x, Numeric2DArray y,
      {Iterable<num> weights, bool copy: true}) {
    // TODO
  }

  LinearRegression fitMultipleX(Numeric2DArray x, Numeric2DArray y) {
    //TODO
  }
}
