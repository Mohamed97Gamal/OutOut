class MyUserInfoResponseOperationResult {
  bool? status;
  String? errorMessage;
  List<String>? errors = [];
  MyUserInfoResponse? result;

  MyUserInfoResponseOperationResult({this.status, this.errorMessage, this.errors, this.result});

  MyUserInfoResponseOperationResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorMessage = json['errorMessage'];
    errors = (json['errors'] as List?)?.map((item) => item as String)?.toList() ?? [];
    result = json['result'] != null ? MyUserInfoResponse.fromJson(json['result']) : null;
  }
}

class MyUserInfoResponse {
  String? id;
  String? fullname;
  String? organizationEmail;
  String? clientEmail;
  List<String>? roles;
  String? profileImageLink;
  String? title;

  bool get isInternalAdmin => roles?.contains("Internal Admin") ?? false;

  MyUserInfoResponse({
    this.id,
    this.fullname,
    this.organizationEmail,
    this.clientEmail,
    this.roles,
    this.profileImageLink,
    this.title,
  });

  MyUserInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    organizationEmail = json['organizationEmail'];
    clientEmail = json['clientEmail'];
    roles = json['roles'].cast<String>();
    profileImageLink = json['profileImageLink'];
    title = json['title'];
  }
}
