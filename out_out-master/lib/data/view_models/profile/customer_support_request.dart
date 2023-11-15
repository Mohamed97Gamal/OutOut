import 'package:out_out/data/models/enums/issue_types.dart';

class CustomerSupportRequest {
  late String fullName;

   String? phoneNumber;

  late IssueTypes issueType;

  late String description;

  CustomerSupportRequest();

  @override
  String toString() {
    return 'CustomerSupportRequest[fullName=$fullName, phoneNumber=$phoneNumber, issueType=$issueType, description=$description, ]';
  }

  CustomerSupportRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    issueType = new IssueTypes.fromJson(json['issueType']);
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {'fullName': fullName, 'phoneNumber': phoneNumber, 'issueType': issueType.value, 'description': description};
  }

  static List<CustomerSupportRequest> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<CustomerSupportRequest>.empty()
        : json.map((value) => new CustomerSupportRequest.fromJson(value)).toList();
  }

  static Map<String, CustomerSupportRequest> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CustomerSupportRequest>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CustomerSupportRequest.fromJson(value));
    }
    return map;
  }
}
