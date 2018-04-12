// Copyright (c) 2017, SERAGUD. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library grizzly.regress;

import 'dart:math' as math;
import 'package:meta/meta.dart';
import 'package:grizzly_array/grizzly_array.dart';
import 'package:grizzly_linalg/grizzly_linalg.dart';

part 'core/base.dart';
part 'core/model.dart';
part 'core/result.dart';

part 'linear/linear.dart';
part 'linear/ols.dart';
part 'linear/ols_gd.dart';

part 'logistic/logistic.dart';

/// Defines interface for regression
abstract class Regression {
  /// Fit simple model with one independent variable
  RegressionResult fitOne(Numeric1D x, Numeric1D y, {bool fitIntercept: false});

  /// Fit model with multiple independent variable
  RegressionResult fit(Numeric2D x, Numeric1D y, {bool fitIntercept: false});

  /// Fit simple model with one independent variable
  RegressionResult fitOneMultivariate(Numeric1D x, Numeric2D y);

  /// Fit model with multiple independent variable
  RegressionResult fitMultivariate(Numeric2D x, Numeric2D y);
}
