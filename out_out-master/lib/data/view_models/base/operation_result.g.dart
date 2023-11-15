// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationResult _$OperationResultFromJson(Map<String, dynamic> json) {
  return OperationResult()
    ..status = json['status'] as bool?
    ..errorCode = json['errorCode'] as int?
    ..errorMessage = json['errorMessage'] as String?
    ..errors =
        (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList();
}

Map<String, dynamic> _$OperationResultToJson(OperationResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorCode': instance.errorCode,
      'errorMessage': instance.errorMessage,
      'errors': instance.errors,
    };
