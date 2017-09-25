// Copyright (c) 2017, SERAGUD. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:grizzly_series/grizzly_series.dart';

/// Defines interface for Linear Models
abstract class LinearModel {
  /// Fit model
  LinearModel fit(Array<num> x, Array<num> y);

  /// Fit model
  LinearModel fitMultipleX(Array2D<num> x, Array2D<num> y);

  dynamic /* TODO */ predict(x);
}

/// Defines interface for regression estimators
abstract class RegressorMixin {
  /// Computes and returns R^2 (coefficient of determination) of the prediction
  double score(x, y, {sampleWeights}) {
    //TODO
  }
}

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

  LinearRegression(this.fitIntercept, this.normalize);

  LinearRegression fit(Array<num> x, Array<num> y) {
    // TODO check X and Y

    // TODO check sample weights

    // TODO process data

    // TODO sample weight

    // TODO linalg.lstsq

    // TODO
  }

  LinearRegression fitMultipleX(Array2D<num> x, Array2D<num> y) {
    //TODO
  }

  // TODO
  dynamic processData(Array<int> x, Array<int> y) {
    //TODO
  }
}