import 'package:grizzly/grizzly.dart';

typedef Metric = num Function(Iterable<num> y, Iterable<num> yPred);

abstract class Metrics {
  static double r2Score(Iterable<num> y, Iterable<num> yPred) {
    // TODO sample_weights
    final ssr = (y - yPred).dot();
    final sst = (y - y.mean).dot();
    return 1 - ssr / sst;
  }

  // TODO sample_weights
  static double mse(Iterable<num> y, Iterable<num> yPred) =>
      (y - yPred).dot() / y.length;

  // TODO sample_weights
  static double rmse(Iterable<num> y, Iterable<num> yPred) =>
      ((y - yPred).dot() / y.length).sqrt;

  // TODO sample_weights
  static double mae(Iterable<num> y, Iterable<num> yPred) =>
      (y - yPred).abs().mean;

  // TODO sample_weights
  static double me(Iterable<num> y, Iterable<num> yPred) => (y - yPred).mean;

  // TODO sample_weights
  static double msle(Iterable<num> y, Iterable<num> yPred) =>
      ((y - 1).log - (yPred - 1).log).mean;

  // TODO sample_weights
  static double rmsle(Iterable<num> y, Iterable<num> yPred) =>
      ((y - 1).log - (yPred - 1).log).mean.sqrt;

  static num maxError(Iterable<num> y, Iterable<num> yPred) =>
      (y - yPred).abs().max;

  static num explainedVarianceScore(Iterable<num> y, Iterable<num> yPred) =>
      1 - (y - yPred).variance / y.variance;
}
