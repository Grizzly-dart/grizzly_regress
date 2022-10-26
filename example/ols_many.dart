import 'package:grizzly/grizzly.dart';
import 'package:grizzly_regress/grizzly_regress.dart';

main() {
  Iterable<double> a = 2.to(6).toDouble();

  Double2DView b = [a * 5, a * 8].transpose.toList2D();

  print(a);
  print(b);

  final res = ols.fitMany(a, b);
  print(res.string());

  print(res.map((e) => e.coeff.print()));

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
