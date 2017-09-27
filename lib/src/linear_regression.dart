part of grizzly.regress;

/// Ordinary least squares Linear Regression
class LinearRegression extends LinearModel with RegressorMixin {
	/// Whether to calculate the intercept for this model
	///
	/// If set to false, no intercept will be used in calculations (e.g. data is
	/// expected to be already centered).
	///
	/// Defaults to true.
	final bool fitIntercept;

	/// If true, the regressors X  will be normalized before regression by
	/// subtracting the mean and dividing by the 12-norm.
	///
	/// It is ignored when [fitIntercept] is false.
	///
	/// TODO clarify confusion with standardization
	///
	/// Defaults to false
	final bool normalize;

	/// Estimated coefficients for the linear regression problem
	dynamic _coeff;

	/// Independent term in the linear model
	dynamic _intercept;

	LinearRegression({this.fitIntercept: true, this.normalize: false});

	LinearRegression fit(NumericArray x, NumericArray y,
			{Iterable<num> weights, bool copy: true}) {
		// TODO check X and Y

		// TODO check sample weights

		// TODO process data
		final procData = new LMProcessedData.process(x, y,
				weights: weights,
				copy: copy,
				fitIntercept: fitIntercept,
				normalize: normalize);

		// TODO sample weight

		// TODO linalg.lstsq
		final results = lstsq(x, y);

		// TODO
	}

	LinearRegression fitMultipleX(Numeric2DArray x, NumericArray y) {
		//TODO
	}
}