// Copyright (c) 2017, SERAGUD. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library grizzly.regress;

import 'package:grizzly_series/grizzly_series.dart';

part 'linear_regression.dart';
part 'multivariate_linear_regression.dart';

/// Defines interface for Linear Models
abstract class LinearModel {
  /// Fit model
  LinearModel fit(NumericArray<num> x, NumericArray<num> y);

  /// Fit model
  LinearModel fitMultipleX(Numeric2DArray<num> x, NumericArray<num> y);

  // TODO dynamic /* TODO */ predict(x);
}

abstract class MultivariateLinearModel {
  /// Fit model
  LinearModel fit(NumericArray<num> x, Numeric2DArray<num> y);

  /// Fit model
  LinearModel fitMultipleX(Numeric2DArray<num> x, Numeric2DArray<num> y);

// TODO dynamic /* TODO */ predict(x);
}

/// Defines interface for regression estimators
abstract class RegressorMixin {
  /// Computes and returns R^2 (coefficient of determination) of the prediction
  double score(x, y, {sampleWeights}) {
    //TODO
  }
}

class LMProcessedData {
  final Numeric2DArray x;

  final NumericArray y;

  final double xOffset;

  final double yOffset;

  final double xScale;

  LMProcessedData(this.x, this.y, this.xOffset, this.yOffset, this.xScale);

  factory LMProcessedData.process(Numeric2DArray x, NumericArray y,
      {Numeric2DArray weights,
      bool fitIntercept: true,
      bool normalize: false,
      bool copy: true}) {
    if (copy) {
      x = x.makeFrom(x);
      y = y.makeFrom(y);
    }

    double xOffset;
    double xScale;
    double yOffset;
    if (fitIntercept) {
      if (weights != null) {
        xOffset = x.average(weights);
        yOffset = y.average(weights);
      } else {
        xOffset = x.mean;
        yOffset = y.mean;
      }
      x.subtract(xOffset);
      y.subtract(yOffset);

      if (normalize) {
        //TODO
        throw new UnimplementedError();
      } else {
        xScale = 1.0;
      }
    } else {
      xOffset = 0.0;
      xScale = 1.0;
      yOffset = 0.0;
    }

    return new LMProcessedData(x, y, xOffset, yOffset, xScale);
  }
}

/// Compute least-squares solution to equation Ax = b
LstSqResult lstsq(Numeric2DArray a, NumericArray b,
    {int steps: 200, double learningRate, double regularization}) {
  final DoubleArray coeff = new DoubleArray.sized(a.shape.x);
  final DoubleArray residuals = new DoubleArray.sized(a.shape.y);
  for(int step = 0; step < steps; step++) {

    //TODO
  }
  //TODO
  return new LstSqResult(coeff, residuals);
}

dynamic lstsqMultivariate(
    Iterable<Iterable<num>> a, Iterable<Iterable<num>> b) {
  //TODO
}

class LstSqResult {
  final DoubleArray coeff;

  final DoubleArray residues;

  LstSqResult(this.coeff, this.residues);
}
