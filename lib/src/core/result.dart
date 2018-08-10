part of grizzly.regress;

class RegressionResult extends RegressionModel implements RegressionResultBase {
  /// Exogenous variables
  final Numeric2DView x;

  /// Endogenous variables
  final Numeric1DView y;

  /// Estimated coefficients for the linear regression problem
  final Double1DFix coeff;

  /// Is the intercept induced by the model?
  final bool interceptFitted;

  /// Normalized Covariance matrix of exogenous variables X
  final Double2DView normalizedCovParams;

  /// Rank of [x]
  final int rank;

  RegressionResult(this.coeff,
      {@required this.x,
      @required this.y,
      @required this.normalizedCovParams,
      @required this.rank,
      this.interceptFitted: false}) {
    if (coeff.length < 2 && interceptFitted)
      throw new Exception('Intercepted not fitted!');
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

  Double1DView _residuals;

  /// The residuals of the model
  Double1DView get residuals => _residuals ??= (y.toDouble() - predict(x)).view;

  double _ssr;

  /// Sum of squared residuals
  double get ssr => _ssr ??= residuals.dot(residuals);

  double _tss;

  /// Un-centered total sum of squares.
  ///
  /// Sum of the squared values of the endogenous response variable
  double get tss => _tss ??= y.dot(y);

  double _centeredTss;

  /// Centered total sum of squares
  double get centeredTss {
    if (_centeredTss != null) return _centeredTss;

    final Double1D centeredY = y - y.mean;
    _centeredTss = centeredY.dot(centeredY);
    return _centeredTss;
  }

  /// Explained sum of squares.
  ///
  /// If a constant is present, the centered total sum of squares minus the sum
  /// of squared residuals.
  /// If there is no constant, the un-centered total sum of squares is used.
  double get ess => interceptFitted ? (centeredTss - ssr) : (tss - ssr);

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
  Double1D get bse => covParams.diagonal.sqrt();

  double get mse => ess / dof;

  double get mseResiduals => ssr / dofResiduals;

  double get mseTotal {
    if (interceptFitted)
      return centeredTss / (dof + dofResiduals);
    else
      return tss / (dof + dofResiduals);
  }

  Double1D _tvalues;

  @override
  /// Returns the t-statistic of the parameter estimate.
  Double1D get tvalues => _tvalues ??= coeff / bse;

  String toString() {
    StringBuffer sb = new StringBuffer();

    final t = table(
        ['Name', 'Value', 'Std err', 't', 'P>|t|', '[0.025', '0.975]'],
        globalPadding: pad(before: 2, after: 2));
    for (int i = 0; i < coeff.length; i++) {
      if (i < (coeff.length - 1) && interceptFitted) {
        t.row([
          x.names[i] ?? 'x$i',
          coeff[i],
          bse[i],
          tvalues[i],
          '-', // TODO
          '-', // TODO
          '-', // TODO
        ]);
      } else {
        t.row([
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
    sb.writeln(t);
    return sb.toString();
  }
}
