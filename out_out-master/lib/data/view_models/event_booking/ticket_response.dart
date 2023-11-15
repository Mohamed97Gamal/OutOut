import 'package:out_out/data/view_models/event_booking/event_package_summary.dart';

class TicketResponse {
  late String id;

  late EventPackageSummary package;

  late String secret;
  late String status;

  DateTime? redemptionDate;

  String qrCodeRelativeUrl(String userId) => "tickets?id=${id}&se=${secret}&userId=${userId}";

  bool get isRedeemed => redemptionDate != null;

  TicketResponse();

  @override
  String toString() {
    return 'TicketResponse[id=$id, package=$package, secret=$secret, redemptionDate=$redemptionDate, ]';
  }

  TicketResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    package = new EventPackageSummary.fromJson(json['package']);
    secret = json['secret'];
    status = json['status'] ?? "UNKNOWN";
    redemptionDate = json['redemptionDate'] == null ? null : DateTime.parse(json['redemptionDate']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'package': package, 'secret': secret, 'redemptionDate': redemptionDate?.toUtc().toIso8601String()};
  }

  static List<TicketResponse> listFromJson(List<dynamic>? json) {
    return json == null ? new List<TicketResponse>.empty() : json.map((value) => new TicketResponse.fromJson(value)).toList();
  }

  static Map<String, TicketResponse> mapFromJson(Map<String, Map<String, dynamic>>? json) {
    var map = new Map<String, TicketResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new TicketResponse.fromJson(value));
    }
    return map;
  }
}
