// Copyright (c) 2017, SERAGUD. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library grizzly.regress;

import 'dart:math' as math;
import 'package:grizzly/grizzly.dart';
import 'package:grizzly_linalg/grizzly_linalg.dart';
import 'package:text_table/text_table.dart';

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
  RegressionResult fit(Num1D x, Num1D y, {bool fitIntercept: false});

  /// Fit model with multiple independent variable
  RegressionResult fitMultivariate(Num2D x, Num1D y,
      {bool fitIntercept: false});

  /// Fit simple model with one independent variable
  List<RegressionResult> fitMany(Iterable<num> x, Num2DView y,
      {bool fitIntercept: false});

  /// Fit model with multiple independent variable
  List<RegressionResult> fitManyMultivariate(Num2D x, Num2D y,
      {bool fitIntercept: false});
}
