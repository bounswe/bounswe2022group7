import 'package:flutter_test/flutter_test.dart';
import 'package:android/util/string_helpers.dart';

void main() {
  group('String to List Converter ', () {

    test('[] for null', () {
      expect(stringToList(null), []);
    });

    test('[] for ""', () {
      expect(stringToList(""), []);
    });

    test('String to List<String> for well-formed inputs', () {
      expect(stringToList('["a", "b", "c"]'), ["a", "b", "c"]);
      expect(stringToList('["hello"]'), ["hello"]);
    });

  });
}
