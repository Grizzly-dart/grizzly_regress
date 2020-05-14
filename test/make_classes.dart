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
      expect(classes.labels, ['zero', 'one', 'two', 'three', 'five']);
      expect(classes.counts,
          {'zero': 3, 'one': 5, 'two': 3, 'three': 5, 'five': 5});
      expect(classes.labelling,
          {'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'five': 4});
      expect(classes.perms, [
        0,
        1,
        3,
        2,
        5,
        6,
        8,
        11,
        4,
        9,
        12,
        7,
        14,
        16,
        18,
        20,
        10,
        13,
        15,
        17,
        19
      ]);
    });
  });
}
