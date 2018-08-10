import 'package:grizzly_array/grizzly_array.dart';
import 'package:grizzly_regress/grizzly_regress.dart';

void withoutIntercept() {
  Double1D a = new Int1D.gen(5, (i) => i + 1).toDouble();

  Double1D b = a * 5;

  final res = ols.fitOne(a, b);
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
  Double1D a = new Int1D.gen(5, (i) => i + 1).toDouble();

  Double1D b = (a * 5) + 3;

  final res = ols.fitOne(a, b, fitIntercept: true);
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
  Double1D a = new Int1D.gen(5, (i) => i + 1).toDouble();

  Double1D b = a.sin();

  final res = ols.fitOne(a, b);
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
