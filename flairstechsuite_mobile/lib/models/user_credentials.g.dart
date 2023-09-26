// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCredentials _$UserCredentialsFromJson(Map<String, dynamic> json) {
  return UserCredentials(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    expirationDateTime: json['expirationDateTime'] as String,
    organizationKey: json['organizationKey'] as String,
  );
}

Map<String, dynamic> _$UserCredentialsToJson(UserCredentials instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expirationDateTime': instance.expirationDateTime,
      'organizationKey': instance.organizationKey,
    };
