import 'package:out_out/data/view_models/profile/issue_type_response.dart';

class CustomerSupportResponse {
  late String id;

  late String fullName;

  late String email;

   String? phoneNumber;

  late IssueTypeResponse issueType;

  late String description;

  CustomerSupportResponse();

  @override
  String toString() {
    return 'CustomerSupportResponse[id=$id, fullName=$fullName, email=$email, phoneNumber=$phoneNumber, issueType=$issueType, description=$description, ]';
  }

  CustomerSupportResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    issueType = new IssueTypeResponse.fromJson(json['issueType']);
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'issueType': issueType,
      'description': description
    };
  }

  static List<CustomerSupportResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CustomerSupportResponse>.empty()
        : json.map((value) => new CustomerSupportResponse.fromJson(value)).toList();
  }

  static Map<String, CustomerSupportResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CustomerSupportResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CustomerSupportResponse.fromJson(value));
    }
    return map;
  }
}
