part of grizzly.regress;

/// Interface for regression result
abstract class RegressionResultBase {
  Double1DView get coeff;

  bool get interceptFitted;

  Double2DView get covariance;

  Numeric2DView get x;

  Numeric1DView get y;

  int get xRank;

  int get numObservations;

  int get dof;

  int get dofResiduals;

  Double1DView get residuals;

  double get ssr;

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