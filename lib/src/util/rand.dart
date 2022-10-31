import 'dart:math';
import 'package:ninja_prime/ninja_prime.dart';

abstract class RandomMapping {
  int transform(int i);
}

class LCGMapping implements RandomMapping {
  final int a;
  final int c;
  final int m;

  LCGMapping(this.a, this.c, this.m);

  factory LCGMapping.make(int m, {Random? random}) {
    random ??= Random();
    int c = random.nextInt(m);

    final primes = m.uniqPrimeFactors;
    // TODO

    // TODO return LCGMapping(a, c, m);

    throw UnimplementedError();
  }

  int transform(int i) => (i * a + c) % m;
}