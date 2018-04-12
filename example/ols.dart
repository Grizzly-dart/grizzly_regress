import 'package:grizzly_array/grizzly_array.dart';
import 'package:grizzly_regress/grizzly_regress.dart';

main() {
  Double1D a = new Int1D([
    1,
    2,
    3,
    4,
    5,
  ]).toDouble;

  Double1D b = a * 5;

  final res = ols.fitOne(a, b);
  print(res.x.transpose);
  print(res.y);
  print(res.coeff);
  print(res.covariance);
}
