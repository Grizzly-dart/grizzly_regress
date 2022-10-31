class LCGMapping {
  final int a;
  final int c;
  final int m;

  LCGMapping(this.a, this.c, this.m);

  int transform(int i) => (i * a + c) % m;
}