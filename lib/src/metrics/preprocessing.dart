import 'package:grizzly/grizzly.dart';

typedef PreProcessor1D = Iterable<num> Function(Iterable<num> x);

abstract class PreProcessor {
  const factory PreProcessor.standardScaler() = StandardScaler;
  const factory PreProcessor.minMaxScaler() = MinMaxScaler;

  Iterable<num> transform(Iterable<num> x);
  Iterable<num> inverse(Iterable<num> x);
}

class StandardScaler implements PreProcessor {
  const StandardScaler();

  Iterable<num> transform(Iterable<num> x) => (x - x.mean) / x.std;
  Iterable<num> inverse(Iterable<num> x) => throw UnimplementedError();
}

class MinMaxScaler implements PreProcessor {
  final Extent<num> range;
  const MinMaxScaler([this.range = const Extent(0, 1)]);

  Iterable<num> transform(Iterable<num> x) {
    final extent = x.extent;
    final d = extent.distance;
    return x.map((e) => range.lower + (e - extent.lower / d) * range.distance);
  }

  Iterable<num> inverse(Iterable<num> x) => throw UnimplementedError();
}

class MaxAbsScaler implements PreProcessor {
  final num max;
  const MaxAbsScaler([this.max = 1]);

  Iterable<num> transform(Iterable<num> x) {
    final m = x.abs().max;
    return x.map((e) => (e * max) / m);
  }

  Iterable<num> inverse(Iterable<num> x) => throw UnimplementedError();
}

class Nomralize implements PreProcessor {
  const Nomralize();

  Iterable<num> transform(Iterable<num> x) {
    final m = x.abs().sum;
    return x.map((e) => e / m);
  }

  Iterable<num> inverse(Iterable<num> x) => throw UnimplementedError();
}

class NomralizeL2 implements PreProcessor {
  const NomralizeL2();

  Iterable<num> transform(Iterable<num> x) {
    final m = x.dot().sqrt;
    return x.map((e) => e / m);
  }

  Iterable<num> inverse(Iterable<num> x) => throw UnimplementedError();
}

class NomralizeAbsMax implements PreProcessor {
  const NomralizeAbsMax();

  Iterable<num> transform(Iterable<num> x) {
    final m = x.abs().max;
    return x.map((e) => e / m);
  }

  Iterable<num> inverse(Iterable<num> x) => throw UnimplementedError();
}

class Binarizer implements PreProcessor {
  final num threshold;
  const Binarizer(this.threshold);

  Iterable<num> transform(Iterable<num> x, {num? threshold}) {
    threshold ??= this.threshold;
    return x.map((e) => e > threshold! ? 1 : 0);
  }

  Iterable<num> inverse(Iterable<num> x) => throw UnimplementedError();
}

// (x - x.min) / (x.max - x.min)
