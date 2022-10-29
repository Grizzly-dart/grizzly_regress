import 'package:grizzly/grizzly.dart';
import 'package:grizzly_regress/grizzly_regress.dart';

void main() {
  Iterable<double> a = 1.to(5).doubleView();

  Iterable<double> b = (a * 5).plus(2);

  final res = SGDRegressor().fit(a, b, fitIntercept: true);
  print(res.x);
  print(res.y);

  res.print();

  print(res.coeff);

  print(res.predict(a.toCol()));
}
