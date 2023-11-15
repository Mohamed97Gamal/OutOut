import 'dart:convert';

import 'package:out_out/data/view_models/auth/otp_verification_time_left_response_operation_result.dart';
import 'package:test/test.dart';

void main() {
  test('Decoding OTPVerificationTimeLeftResponseOperationResult when result is null', () {
    final jsonString = '{ "status": false, "result": null, "errorCode": 0, "errorMessage": null, "errors": [] }';
    final jsonMap = json.decode(jsonString);
    final result = OTPVerificationTimeLeftResponseOperationResult.fromJson(jsonMap);
    expect(result, isNot(equals(null)));
  });
}
