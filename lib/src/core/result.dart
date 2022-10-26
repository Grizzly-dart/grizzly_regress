part of grizzly.regress;

class RegressionResult extends RegressionModel implements RegressionResultBase {
  /// Exogenous variables
  final Num2DView x;

  /// Endogenous variables
  final Iterable<num> y;

  /// Estimated coefficients for the linear regression problem
  final Iterable<num> coeff;

  /// Is the intercept induced by the model?
  final bool interceptFitted;

  /// Normalized Covariance matrix of exogenous variables X
  final Double2DView normalizedCovParams;

  /// Rank of [x]
  final int rank;

  RegressionResult(this.coeff,
      {required this.x,
      required this.y,
      required this.normalizedCovParams,
      required this.rank,
      this.interceptFitted: false}) {
    if (coeff.length < 2 && interceptFitted)
      throw Exception('Intercepted not fitted!');
  }

  Double2DView get covParams => normalizedCovParams * scale;

  /// Mean square error from the estimated model (sigma^2)
  double get scale => residuals.dot(residuals) / dofResiduals;

  @override
  double get logLikelihood {
    double nobsdiv2 = nObs / 2;
    double ll = -nobsdiv2 * math.log(2 * math.pi);
    ll -= -nobsdiv2 * math.log(ssr / nObs);
    ll -= nObs;
    return ll;
  }

  /// Number of observations
  int get nObs => x.numRows;

  /// The model degree of freedom
  ///
  /// Defined as the rank of the regressor matrix minus 1 if a constant is included
  int get dof => interceptFitted ? (rank - 1) : rank;

  /// The residual degree of freedom
  ///
  /// Defined as the number of observations minus the rank of the regressor matrix.
  int get dofResiduals => nObs - rank;

  /// The residuals of the model
  late final Iterable<num> residuals = y - predict(x);

  /// Sum of squared residuals
  late final num ssr = residuals.dot(residuals);

  /// Un-centered total sum of squares.
  ///
  /// Sum of the squared values of the endogenous response variable
  late final num tss = y.dot(y);

  /// Centered total sum of squares
  late final num centeredTss = _centeredTss();

  num _centeredTss() {
    final Iterable<num> centeredY = y - y.mean;
    return centeredY.dot(centeredY);
  }

  /// Explained sum of squares.
  ///
  /// If a constant is present, the centered total sum of squares minus the sum
  /// of squared residuals.
  /// If there is no constant, the un-centered total sum of squares is used.
  late final num ess = interceptFitted ? (centeredTss - ssr) : (tss - ssr);

  /// R-squared of a model with an intercept.
  ///
  /// This is defined here as 1 - [ssr]/[tss] if the constant is
  /// included in the model.
  /// 1 - [ssr]/[uncenteredTss] if the constant is omitted.
  double get r2 => interceptFitted ? (1 - ssr / centeredTss) : (1 - ssr / tss);

  double get r2Adjusted {
    if (!interceptFitted) {
      return 1 - (nObs / dofResiduals) * (1 - r2);
    } else {
      return 1 - ((nObs - 1) / dofResiduals) * (1 - r2);
    }
  }

  /// The standard errors of the parameter estimates.
  late final Iterable<double> bse = covParams.diagonal.sqrt();

  double get mse => ess / dof;

  double get mseResiduals => ssr / dofResiduals;

  double get mseTotal {
    if (interceptFitted)
      return centeredTss / (dof + dofResiduals);
    else
      return tss / (dof + dofResiduals);
  }

  /// Returns the t-statistic of the parameter estimate.
  @override
  late final Iterable<double> tvalues = coeff / bse;

  String toString({TableRenderer renderer = const TableRenderer()}) {
    final rows = <List>[];
    for (int i = 0; i < coeff.length; i++) {
      if (i < (coeff.length - 1) && interceptFitted) {
        rows.add([
          x is Named2DView ? (x as Named2DView).names[i] : 'x$i',
          coeff[i],
          bse[i],
          tvalues[i],
          '-', // TODO
          '-', // TODO
          '-', // TODO
        ]);
      } else {
        rows.add([
          'intercept',
          coeff[i],
          bse[i],
          tvalues[i],
          '-', // TODO
          '-', // TODO
          '-', // TODO
        ]);
      }
    }
    return renderer.render(rows, columns: [
      'Name',
      'Value',
      'Std err',
      't',
      'P>|t|',
      '[0.025',
      '0.975]',
    ]);
  }
}
