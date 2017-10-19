// Copyright (c) 2017, SERAGUD. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:grizzly_series/grizzly_series.dart';
import 'package:grizzly_regress/grizzly_regress.dart';

int h(int x) => x * 5;

main() {
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
  final x = new Double2DArray.fromNum([
    [1],
    [2],
    [3],
    [4],
    [5],
  ]);

  final y = x.col[0] * 5;
  print(y);

  final xQR = qr(x);
  print(xQR.q);
  print(xQR.r);

  print(xQR.q.dot(xQR.r));

  print(xQR.solve(y.transpose()));
  */

  /*
  print(array2D([
        [3.0, 1.0],
        [1.0, 2.0]
      ]) *
      array2D([
        [2.0],
        [3.0]
      ]));
      */
}
