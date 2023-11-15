import 'package:json_annotation/json_annotation.dart';

part 'operation_result.g.dart';

@JsonSerializable()
class OperationResult {
  bool? status;
  int? errorCode;
  String? errorMessage;
  List<String>? errors;

  OperationResult();

  factory OperationResult.fromError(int statusCode, String errorMessage) {
    var operationResult = OperationResult();
    operationResult.status = false;
    operationResult.errorCode = statusCode;
    operationResult.errorMessage = errorMessage;
    operationResult.errors = [];
    return operationResult;
  }

  factory OperationResult.fromJson(Map<String, dynamic> json) => _$OperationResultFromJson(json);

  Map<String, dynamic> toJson() => _$OperationResultToJson(this);
}
