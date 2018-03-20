import 'package:grizzly_regress/grizzly_regress.dart';
import 'package:grizzly_array/grizzly_array.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {});

    test('First Test', () {
      final y = new String1D([
        'zero',
        'zero',
        'one',
        'zero',
        'two',
        'one',
        'one',
        'three',
        'one',
        'two',
        'five',
        'one',
        'two',
        'five',
        'three',
        'five',
        'three',
        'five',
        'three',
        'five',
        'three',
      ]);
      final classes = new MakeClasses.label(y);
      print(classes.labels);
    });
  });
}
