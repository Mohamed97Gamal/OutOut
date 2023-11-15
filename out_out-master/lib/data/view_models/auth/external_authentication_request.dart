import 'package:out_out/data/view_models/auth/external_provider.dart';

class ExternalAuthenticationRequest {
  late ExternalProvider externalLoginProvider;

  late String accessToken;

  String? firebaseMessagingToken;

  String? fullName;

  ExternalAuthenticationRequest({
    required this.externalLoginProvider,
    required this.accessToken,
    required this.firebaseMessagingToken,
    this.fullName,
  });

  @override
  String toString() {
    return 'ExternalAuthenticationRequest[externalLoginProvider=$externalLoginProvider, accessToken=$accessToken, firebaseMessagingToken=$firebaseMessagingToken, fullName=$fullName, ]';
  }

  ExternalAuthenticationRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    externalLoginProvider = new ExternalProvider.fromJson(json['externalLoginProvider']);
    accessToken = json['accessToken'];
    firebaseMessagingToken = json['firebaseMessagingToken'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'externalLoginProvider': externalLoginProvider.value,
      'accessToken': accessToken,
      'firebaseMessagingToken': firebaseMessagingToken,
      'fullName': fullName
    };
  }

  static List<ExternalAuthenticationRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<ExternalAuthenticationRequest>.empty()
        : json.map((value) => new ExternalAuthenticationRequest.fromJson(value)).toList();
  }

  static Map<String, ExternalAuthenticationRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, ExternalAuthenticationRequest>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new ExternalAuthenticationRequest.fromJson(value));
    }
    return map;
  }
}
