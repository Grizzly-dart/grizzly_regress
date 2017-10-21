part of grizzly.regress;

class RegressionResult extends RegressionModel implements RegressionResultBase {
	/// Estimated coefficients for the linear regression problem
	final Double1DView coeff;

	/// Is the intercept induced by the model?
	final bool interceptFitted;

	// TODO make this view
	/// Covariance matrix of exogenous variables X
	final Double2DView covMatrix;

	// TODO make this view
	/// Exogenous variables
	final Numeric2DView x;

	// TODO make this view
	/// Endogenous variables
	final Numeric1DView y;

	/// Rank of [x]
	final int xRank;

	RegressionResult(this.coeff,
			{@required this.x,
				@required this.y,
				@required this.covMatrix,
				@required this.xRank,
				this.interceptFitted: false}) {
		if (coeff.length < 2 && interceptFitted) throw new Exception('Intercepted not fitted!');
	}

	// TODO scale

	/// Number of observations
	int get numObservations => x.numRows;

	/// The model degree of freedom
	///
	/// Defined as the rank of the regressor matrix minus 1 if a constant is included
	int get dof => interceptFitted ? (xRank - 1) : xRank;

	/// The residual degree of freedom
	///
	/// Defined as the number of observations minus the rank of the regressor matrix.
	int get dofResiduals => numObservations - xRank;

	Double1DView _residuals;

	/// The residuals of the model
	Double1DView get residuals =>
			_residuals ??= (y - predictMany(x)).toDouble.view;

	double _ssr;

	/// Sum of squared residuals (TODO: whitened?)
	double get ssr => _ssr ??= residuals.dot(residuals);

	double _tss;

	/// Un-centered sum of squares.
	///
	/// Sum of the squared values of the endogenous response variable
	double get tss => _tss ??= y.dot(y);

	double _centeredTss;

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
			return 1 - (numObservations / dofResiduals) * (1 - r2);
		} else {
			return 1 - ((numObservations - 1) / dofResiduals) * (1 - r2);
		}
	}

	/// The standard errors of the parameter estimates
	Double1D get bse => covMatrix.diagonal.sqrt();

	double get mse => ess / dof;

	double get mseResiduals => ssr / dofResiduals;

	double get mseTotal {
		if (interceptFitted) {
			return centeredTss / (dof + dofResiduals);
		} else {
			return tss / (dof + dofResiduals);
		}
	}
}
