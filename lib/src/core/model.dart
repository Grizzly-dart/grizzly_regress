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
	double predict(Iterable<num> x) {
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
	Double1D predictMany(Iterable<Iterable<num>> x) {
		final ret = new Double1D.sized(x.length);

		for (int i = 0; i < x.length; i++) {
			Iterable<num> row = x.elementAt(i);
			ret[i] = predict(row);
		}

		return ret;
	}
}

/// Interface for regression result
abstract class RegressionResultBase {
	Double1DView get coeff;

	bool get interceptFitted;

	Double2DView get covMatrix;

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