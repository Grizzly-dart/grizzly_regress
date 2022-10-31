class Split {
  final Iterable<int> train;
  final Iterable<int> test;

  Split(this.train, this.test);
}

abstract class Splitter {
  Iterable<Split> split(int splits);
}

class KFold implements Splitter {
  Iterable<Split> split(int splits) {
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
