import 'package:android/util/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Email Validator', () {

    test('should return "Your email is required" if value is empty', () {
      expect(validateEmail(""), "Your email is required");
    });

    test('should return null for valid email', () {
      expect(validateEmail("a@a.co"), null);
    });

    test('should return "Please provide a valid email address" for invalid email', () {
      expect(validateEmail("aaa"), "Please provide a valid email address");
    });
  });
}
