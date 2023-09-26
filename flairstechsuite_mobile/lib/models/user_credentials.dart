import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_credentials.g.dart';

@JsonSerializable()
class UserCredentials {
  final String? accessToken;
  final String? refreshToken;
  final String? expirationDateTime;
  final String? organizationKey;

  UserCredentials(
      {this.accessToken,
      this.refreshToken,
      this.expirationDateTime,
      this.organizationKey});

  factory UserCredentials.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$UserCredentialsToJson(this);

  static Future<UserCredentials> fromSecureStorage() async {
    final storage = FlutterSecureStorage();
    final accessToken = await storage.read(
        key: "accessToken", iOptions: SecureStorageExt.defaultIosOptions);
    final refreshToken = await storage.read(
        key: "refreshToken", iOptions: SecureStorageExt.defaultIosOptions);
    final expirationDateTime = await storage.read(
        key: "expirationDateTime",
        iOptions: SecureStorageExt.defaultIosOptions);
    final organizationKey = await storage.read(
        key: "organizationKey", iOptions: SecureStorageExt.defaultIosOptions);

    return UserCredentials(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expirationDateTime: expirationDateTime,
        organizationKey: organizationKey);
  }

  static Future<void> removeFromSecureStorage() async {
    final storage = FlutterSecureStorage();
    await storage.delete(
        key: "accessToken", iOptions: SecureStorageExt.defaultIosOptions);
    await storage.delete(
        key: "refreshToken", iOptions: SecureStorageExt.defaultIosOptions);
    await storage.delete(
        key: "expirationDateTime",
        iOptions: SecureStorageExt.defaultIosOptions);
    await storage.delete(
        key: "organizationKey", iOptions: SecureStorageExt.defaultIosOptions);
  }

  saveToSecureStorage() async {
    final storage = FlutterSecureStorage();
    if (accessToken != null)
      await storage.write(
          key: "accessToken",
          value: accessToken,
          iOptions: SecureStorageExt.defaultIosOptions);
    if (refreshToken != null)
      await storage.write(
          key: "refreshToken",
          value: refreshToken,
          iOptions: SecureStorageExt.defaultIosOptions);
    if (expirationDateTime != null)
      await storage.write(
          key: "expirationDateTime",
          value: expirationDateTime,
          iOptions: SecureStorageExt.defaultIosOptions);
    if (organizationKey != null)
      await storage.write(
          key: "organizationKey",
          value: organizationKey,
          iOptions: SecureStorageExt.defaultIosOptions);
  }
}

extension SecureStorageExt on FlutterSecureStorage {
  static IOSOptions get defaultIosOptions =>
      IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);
}
