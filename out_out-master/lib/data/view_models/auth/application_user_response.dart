import 'package:out_out/data/models/enums/gender.dart';
import 'package:out_out/data/view_models/user_location.dart';

class ApplicationUserResponse {
  late String id;
  late String fullName;
  late String email;
  Gender? gender;
  String? profileImage;
  late bool emailConfirmed;
  String? phoneNumber;
  late UserLocation location;
  late bool notificationsAllowed;
  late bool remindersAllowed;
  late bool isPasswordSet;

  ApplicationUserResponse();

  @override
  String toString() {
    return 'ApplicationUserResponse[id=$id, fullName=$fullName, email=$email, gender=$gender, profileImage=$profileImage, emailConfirmed=$emailConfirmed, phoneNumber=$phoneNumber, location=$location, notificationsAllowed=$notificationsAllowed, remindersAllowed=$remindersAllowed ]';
  }

  ApplicationUserResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    gender = new Gender.fromJson(json['gender']);
    profileImage = json['profileImage'];
    emailConfirmed = json['emailConfirmed'];
    phoneNumber = json['phoneNumber'];
    location = new UserLocation.fromJson(json['location']);
    notificationsAllowed = json['notificationsAllowed'];
    remindersAllowed = json['remindersAllowed'];
    isPasswordSet = json['isPasswordSet'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'gender': gender,
      'profileImage': profileImage,
      'emailConfirmed': emailConfirmed,
      'phoneNumber': phoneNumber,
      'location': location,
      'notificationsAllowed': notificationsAllowed,
      'remindersAllowed': remindersAllowed,
      'isPasswordSet': isPasswordSet
    };
  }

  static List<ApplicationUserResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? List<ApplicationUserResponse>.empty()
        : json.map((value) => new ApplicationUserResponse.fromJson(value)).toList();
  }

  static Map<String, ApplicationUserResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, ApplicationUserResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ApplicationUserResponse.fromJson(value));
    }
    return map;
  }
}
