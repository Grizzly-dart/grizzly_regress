import 'package:grizzly/grizzly.dart';
import 'package:grizzly_regress/grizzly_regress.dart';

void main() {
  Iterable<double> a = 1.to(5).toDouble();

  Iterable<double> b = a * 5;

  final res = OLS_GD().fit(a, b);
  print(res.x.transpose);
  print(res.y);

  res.print();

  print(res.coeff);
  /* TODO
  print(res.scale);
  print(res.residuals);
  print(res.normalizedCovParams);
  print(res.covParams);
  print(res.logLikelihood);
  print(res.bse);
  print(res.tvalues);
   */
}
