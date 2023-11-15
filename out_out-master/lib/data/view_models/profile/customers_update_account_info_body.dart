import 'package:out_out/data/models/enums/gender.dart';

class CustomersUpdateAccountInfoBody {
  late String fullName;

  late String phoneNumber;

  late Gender gender;

  late String profileImage;

  CustomersUpdateAccountInfoBody();

  @override
  String toString() {
    return 'CustomersUpdateAccountInfoBody[fullName=$fullName, phoneNumber=$phoneNumber, gender=$gender, profileImage=$profileImage, ]';
  }

  CustomersUpdateAccountInfoBody.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    fullName = json['FullName'];
    phoneNumber = json['PhoneNumber'];
    gender = new Gender.fromJson(json['Gender']);
    profileImage = json['ProfileImage'];
  }

  Map<String, dynamic> toJson() {
    return {'FullName': fullName, 'PhoneNumber': phoneNumber, 'Gender': gender, 'ProfileImage': profileImage};
  }

  static List<CustomersUpdateAccountInfoBody> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<CustomersUpdateAccountInfoBody>.empty()
        : json.map((value) => new CustomersUpdateAccountInfoBody.fromJson(value)).toList();
  }

  static Map<String, CustomersUpdateAccountInfoBody> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, CustomersUpdateAccountInfoBody>();
    if (json != null && json.length > 0) {
      json.forEach(
          (String key, Map<String, dynamic> value) => map[key] = new CustomersUpdateAccountInfoBody.fromJson(value));
    }
    return map;
  }
}
