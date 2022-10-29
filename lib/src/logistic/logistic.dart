part of grizzly.regress;

class LinearClassifier {
  bool predict(Double2DView x) {
    // TODO
    throw UnimplementedError();
  }

  // TODO decisionFunction();

  // TODO
}

/// Logistic Regression (aka logit, MaxEnt) classifier
class LogisticRegression {
  /// Fit simple model with one independent variable
  OLSResult fit(Num1D x, Num1D y, {bool fitIntercept: false}) {
    // TODO
    throw UnimplementedError();
  }

  /// Fit model with multiple independent variable
  OLSResult fitMultipleX(Num2D x, Num1D y, {bool fitIntercept: false}) {
    // TODO
    throw UnimplementedError();
  }
}

class LibLinear {
  LibLinear(Double2D x, Iterable<num> y, {double interceptScale: -1.0}) {
    final int l = x.numRows;
    final int n = x.numCols;

    // Group training data of the same class
    final classes = MakeClasses.label(y);

    // TODO weights

    // TODO make new x and sort by label

    // TODO
  }
}

class MakeClasses<T> {
  final List<T> labels;

  final Map<dynamic, int> labelling;

  final Map<dynamic, int> counts;

  final Iterable<int> yLabelled;

  final List<int> starts;

  // TODO why this peculiar name?
  final List<int> perms;

  MakeClasses(
      {required this.labels,
      required this.labelling,
      required this.counts,
      required this.yLabelled,
      required this.starts,
      required this.perms});

  factory MakeClasses.label(Iterable<T> y) {
    final labels = <T>[];
    final labelling = <dynamic, int>{};
    final counts = <dynamic, int>{};
    final yLabelled = List<int>.filled(y.length, 0);

    // Find classes and class counts
    for (int i = 0; i < y.length; i++) {
      final thisLabel = y[i];
      if (labelling.containsKey(thisLabel)) {
        counts[thisLabel] = counts[thisLabel]! + 1;
      } else {
        labelling[thisLabel] = labels.length;
        counts[thisLabel] = 1;
        labels.add(thisLabel);
      }
      yLabelled[i] = labelling[thisLabel]!;
    }

    // Compute starts
    final starts = List<int>.filled(labels.length, 0);
    starts[0] = 0;
    for (int i = 1; i < labels.length; i++)
      starts[i] = starts[i - 1] + counts[labels[i - 1]]!;

    final perms = List<int>.filled(y.length, 0);
    for (int i = 0; i < y.length; i++) {
      perms[starts[yLabelled[i]]] = i;
      starts[yLabelled[i]]++;
    }

    // Compute starts
    starts[0] = 0;
    for (int i = 1; i < labels.length; i++)
      starts[i] = starts[i - 1] + counts[labels[i]]!;

    return MakeClasses(
        labels: labels,
        labelling: labelling,
        counts: counts,
        yLabelled: yLabelled,
        starts: starts,
        perms: perms);
  }
}
