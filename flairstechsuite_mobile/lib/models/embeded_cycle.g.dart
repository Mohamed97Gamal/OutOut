// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embeded_cycle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmbededCycle _$EmbededCycleFromJson(Map<String, dynamic> json) {
  return EmbededCycle(
    id: json['id'] as String,
    name: json['name'] as String,
    from: json['from'] as String,
    to: json['to'] as String,
  );
}

Map<String, dynamic> _$EmbededCycleToJson(EmbededCycle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'from': instance.from,
      'to': instance.to,
    };
