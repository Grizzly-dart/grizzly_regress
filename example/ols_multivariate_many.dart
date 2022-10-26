import 'package:grizzly/grizzly.dart';
import 'package:grizzly_regress/grizzly_regress.dart';

main() {
  Num2DView a = [2.to(6), 11.to(15)].transpose;

  Num2DView b = [a.cols[0] * 5, a.cols[1] * 8].transpose;

  print(a);
  print(b);

  final res = ols.fitManyMultivariate(a, b);
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
