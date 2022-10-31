import 'dart:math';

import 'package:grizzly/grizzly.dart';
import 'package:grizzly_linalg/grizzly_linalg.dart';
import 'package:grizzly_regress/grizzly_regress.dart';

import 'package:json_stream/json_stream.dart';

void main() {
  final rnd = Random(5);

  Iterable<double> a = 1.to(10).doubleView();
  final b = a.map((e) => rnd.nextDouble().toPrecision(3));
  final x = [a, b].transpose.toList();
  print(x.tableString());
  Iterable<double> y = (a * 5).plus(2);
  print(y);

  {
    print('SGD:');
    final model = SGDRegressor(maxIterations: 5000000)
        .fitMultivariate(x, y, fitIntercept: true);
    model.print();
    print(model.coeff);
    print(model.predict(x));
  }

  {
    print('Lasso:');
    final model = SGDRegressor(
            maxIterations: 100000, regularizer: LassoRegularizer(0.0001))
        .fitMultivariate(x, y, fitIntercept: true);
    model.print();
    print(model.coeff);
    print(model.predict(x));
  }

  {
    print('Ridge:');
    final model = SGDRegressor(
            maxIterations: 100000, regularizer: RidgeRegularizer(0.0001))
        .fitMultivariate(x, y, fitIntercept: true);
    model.print();
    print(model.coeff);
    print(model.predict(x));
  }
}
