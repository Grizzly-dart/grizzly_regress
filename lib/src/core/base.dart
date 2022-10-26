part of grizzly.regress;

/// Interface for regression result
abstract class RegressionResultBase {
  Iterable<num> get coeff;

  bool get interceptFitted;

  Double2DView get normalizedCovParams;

  Num2DView get x;

  Iterable<num> get y;

  int get rank;

  /// Mean square error from the estimated model (sigma^2)
  double get scale;

  double get logLikelihood;

  // TODO score

  Double2DView get covParams;

  /// Number of observations
  int get nObs;

  int get dof;

  int get dofResiduals;

  Iterable<num> get residuals;

  num get ssr;

  num get tss;

  num get centeredTss;

  num get ess;

  double get r2;

  double get r2Adjusted;

  /// The standard errors of the parameter estimates
  Iterable<double> get bse;

  /// Mean squared error of the model.
  ///
  /// Explained sum of squares divided by the model's degrees of freedom.
  double get mse;

  /// Mean squared error of the residuals.
  ///
  /// The sum of squares of residuals divided by the residual degrees of freedom.
  double get mseResiduals;

  /// Total mean squared error.
  ///
  /// The uncentered total sum of squares divided by the number of observations.
  double get mseTotal;

  /// Returns the t-statistic of the parameter estimate.
  Iterable<double> get tvalues;

// TODO
}