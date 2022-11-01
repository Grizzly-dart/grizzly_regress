import 'package:grizzly/grizzly.dart';

class Split {
  final Iterable<int> train;
  final Iterable<int> test;

  Split(this.train, this.test);
}

abstract class Splitter {
  Iterable<Split> split(int splits);
}

class KFold implements Splitter {
  Iterable<Split> split(int items, int splits) {
    final n = items ~/ splits;
    final m = items % splits;

    for(int i = 0; i < splits-m; i++) {
      1.to();
      // TODO
    }

    for(int i = 0; i < m; i++) {
      // TODO
    }
/*
def split(x,y):
    print('-------')
    n=math.floor(x/y)
    print(n)
    m=x%y
    print(m)
    for i in range(y-m):
        print([(i*n)+r for r in range(n)])
    for i in range(m):
        print([(y-m)*n+(i*(n+1))+r for r in range(n+1)])
 */
    // TODO
    throw UnimplementedError();
  }
}
