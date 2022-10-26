// Copyright (c) 2017, SERAGUD. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:grizzly/grizzly.dart';
import 'package:grizzly_regress/grizzly_regress.dart';
import 'package:grizzly_linalg/grizzly_linalg.dart';

main() {
  /*
  final a = array2([
    [1, 0, 1],
    [-1, -2, 0],
    [0, 1, -1]
  ]);
  */

  /*
  final a = array2D([
    [1, 2],
    [3, 4],
    [5, 6],
    [7, 8]
  ]);
  */

  /*
  final SVD asvd = svd(a);
  print(asvd.u);
  print(asvd.s);
  print(asvd.v);
  print(asvd.u *
      Double2D.diagonal(asvd.s) *
      asvd.v.transpose);
      */

  /* TODO
  final u = array2D([
    [-0.1525, -0.8226],
    [-0.3499, -0.4214],
    [-0.5474, -0.0201],
    [-0.7448, 0.3812]
  ]);
  final s = array2D([[14.2691, 0], [0, 0.6268]]);
  final v = array2D([[-0.6414, 0.7672], [-0.7672, -0.6414]]);
  print(u * s * v.transpose);
  */

  /*
  final x = Int2D.columns([
    List<int>.generate(100, (i) => i + 1),
  ]).toDouble;
  print(x);
  final y = (x * [5]).row.sum;
  print(y);
  */

  /*
  final res1 = OLSGD().fitMultipleX(x, y);
  print(res1.coeff);
  print(res1.predict(x[0].toInt()));
  */

  /*
  final lst =
      StochasticLeastSquareGradientDescent(x, y, maxIterations: 100);
  lst.learn();
  print(lst.params);
  */

  /*
  final x = array2D([
    [1, 2],
    [2, 3],
    [3, 4],
    [4, 5],
    [5, 6],
  ]);
  final y = (x * [5, 2]).row.sum + 7;
  print(y);
  final RegressionResult res = ols.fitMultipleX(x, y, fitIntercept: true);
  print(res.coeff);
  print(res.predict(x[0].toInt()));
  */

  /* TODO
  final xQR = qr(x);
  print(xQR.q);
  print(xQR.r);

  final LU xLU = lu(x);

  print(xLU.pivotMatrix);

  print(xLU.lowerFactor);

  print(xLU.upperFactor);

  print(xLU.pivotMatrix * xLU.lowerFactor * xLU.upperFactor);

  final b = solve(xQR.r, xQR.q.transpose * y.transpose);

  print(b);

  print(x * b);
  */

  /*
  final x = array2D([
    [1, 2],
    [2, 3],
    [3, 4],
    [4, 5],
    [5, 6],
  ]);

  final y = (x * [5, 2]).sumCol;
  print(y);

  final xQR = qr(x);
  print(xQR.q);
  print(xQR.r);
  print(xQR.rDiag);

  print(xQR.q.dot(xQR.r));

  print((xQR.q.transpose * y).transpose);

  final b = xQR.solve(y.transpose);
  print(b);
  print(x * b);
  */

  /*

  */
}
