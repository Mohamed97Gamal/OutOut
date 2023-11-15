import 'package:out_out/utils/validators.dart';
import 'package:test/test.dart';

void main() {
  group("Validators Tests", () {
    test("Validator.password valid cases", () {
      final cases = [
        "Test@123",
        "Kk@12345",
      ];
      for (final value in cases) {
        var isValid = Validators.password(value, null);
        expect(isValid, null);
      }
    });

    test("Validator.password invalid cases", () {
      final cases = [
        "Kk@1234",
        "12345678",
        "K1234567",
        "Kk123456",
        "Kk@1234567890123456789012345",
        "Kk@1234567890123456789012345Kk@",
      ];
      for (final value in cases) {
        var result = Validators.password(value, null);
        expect(result, isNotNull);
      }
    });

    test("Validator.phoneNumber valid cases", () {
      final cases = [
        "+971123456789",
      ];
      for (final value in cases) {
        var result = Validators.phoneNumber(value, null);
        expect(result, null);
      }
    });

    test("Validator.phoneNumber invalid cases", () {
      final cases = [
        "+97112345678",
        "+971012345678912",
        "971012345678912",
        "+123012345678912",
        "+973012345678912",
        "+9710123456789",
      ];
      for (final value in cases) {
        var result = Validators.phoneNumber(value, null);
        expect(result, isNotNull);
      }
    });

    test("Validator.email valid cases", () {
      final cases = [
        "kirolous.nashaat@flairstech.com",
        "KIROLOUS.nashaat@flairstech.com",
      ];
      for (final value in cases) {
        var isValid = Validators.email(value, null);
        expect(isValid, null);
      }
    });
  });
}
