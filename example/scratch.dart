import 'package:grizzly_regress/grizzly_regress.dart';
import 'package:grizzly_series/grizzly_series.dart';

void main() {
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
  print(classes.counts);
  print(classes.labelling);
  print(classes.perms);
}
