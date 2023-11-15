import 'dart:convert';

import 'package:out_out/data/view_models/auth/application_user_response_operation_result.dart';
import 'package:test/test.dart';

void main() {
  test('Decoding ApplicationUserResponseOperationResult when result is null', () {
    final jsonString = '{ "status": false, "result": null, "errorCode": 0, "errorMessage": null, "errors": [] }';
    final jsonMap = json.decode(jsonString);
    final result = ApplicationUserResponseOperationResult.fromJson(jsonMap);
    expect(result, isNot(equals(null)));
  });
}
