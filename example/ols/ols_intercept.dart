import 'package:grizzly/grizzly.dart';
import 'package:grizzly_regress/grizzly_regress.dart';

void withoutIntercept() {
  Iterable<double> a = 1.to(5).toDouble();

  Iterable<double> b = a * 5;

  final res = ols.fit(a, b);
  print(res.x.transpose);
  print(res.y);

  print(res);

  /*
  print(res.coeff);
  print(res.scale);
  print(res.residuals);
  print(res.normalizedCovParams);
  print(res.covParams);
  print(res.logLikelihood);
  print(res.bse);
  print(res.tvalues);
  */
}

void withIntercept() {
  Iterable<double> a = 1.to(5).toDouble();

  Iterable<double> b = (a * 5).plus(3);

  final res = ols.fit(a, b, fitIntercept: true);
  print(res.x.transpose);
  print(res.y);

  print(res);

  /*
  print(res.coeff);
  print(res.scale);
  print(res.residuals);
  print(res.normalizedCovParams);
  print(res.covParams);
  print(res.logLikelihood);
  print(res.bse);
  print(res.tvalues);
  */
}

void highVariance() {
  Iterable<double> a = 1.to(5).toDouble();

  Iterable<double> b = a.sin();

  final res = ols.fit(a, b);
  print(res.x.transpose);
  print(res.y);

  print(res);

  /*
  print(res.coeff);
  print(res.scale);
  print(res.residuals);
  print(res.normalizedCovParams);
  print(res.covParams);
  print(res.logLikelihood);
  print(res.bse);
  print(res.tvalues);
  */
}

main() {
  print("Without intercept:");
  withoutIntercept();

  print("\n\nWith intercept:");
  withIntercept();

  print("\n\nHigh variance:");
  highVariance();
}
