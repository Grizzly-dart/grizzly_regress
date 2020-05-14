part of grizzly.regress;

/// Interface for regression result
abstract class RegressionResultBase {
  Double1DView get coeff;

  bool get interceptFitted;

  Double2DView get normalizedCovParams;

  Numeric2DView get x;

  Numeric1DView get y;

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

  Double1DView get residuals;

  double get ssr;

  double get tss;

  double get centeredTss;

  double get ess;

  double get r2;

  double get r2Adjusted;

  /// The standard errors of the parameter estimates
  Double1D get bse;

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
  Double1D get tvalues;

// TODO
}


/// Interface for regression result
abstract class MultivariateRegressionResultBase {
  Double1DView get coeff;

  bool get interceptFitted;

  Double2DView get normalizedCovParams;

  Numeric2DView get x;

  Numeric2DView get y;

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

  Double2DView get residuals;

  Double1D get ssr;

  double get tss;

  double get centeredTss;

  double get ess;

  double get r2;

  double get r2Adjusted;

  Double1D get bse;

  double get mse;

  double get mseResiduals;

  double get mseTotal;

// TODO
}