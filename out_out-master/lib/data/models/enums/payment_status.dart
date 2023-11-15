
class PaymentStatus {
  int value = 0;

  PaymentStatus._internal(this.value);

  static PaymentStatus unKnown = PaymentStatus._internal(0);
  static PaymentStatus pending = PaymentStatus._internal(1);
  static PaymentStatus paid = PaymentStatus._internal(2);
  static PaymentStatus cancelled = PaymentStatus._internal(3);
  static PaymentStatus declined = PaymentStatus._internal(4);
  static PaymentStatus failed = PaymentStatus._internal(5);
  static PaymentStatus aborted = PaymentStatus._internal(6);
  static PaymentStatus expired = PaymentStatus._internal(7);
  static PaymentStatus onHold = PaymentStatus._internal(8);
  static PaymentStatus rejected = PaymentStatus._internal(9);

  String get name {
    switch (value) {
      case 0:
        return "UnKnown";
      case 1:
        return "Pending";
      case 2:
        return "Paid";
      case 3:
        return "Cancelled";
      case 4:
        return "Declined";
      case 5:
        return "Failed";
      case 6:
        return "Aborted";
      case 7:
        return "Expired";
      case 8:
        return "OnHold";
      case 9:
        return "Rejected";
      default:
        throw ('Unknown enum value to decode name');
    }
  }

  PaymentStatus.fromJson(dynamic data) {
    switch (data) {
      case 0:
        value = data;
        break;
      case 1:
        value = data;
        break;
      case 2:
        value = data;
        break;
      case 3:
        value = data;
        break;
      case 4:
        value = data;
        break;
      case 5:
        value = data;
        break;
      case 6:
        value = data;
        break;
      case 7:
        value = data;
        break;
      case 8:
        value = data;
        break;
      case 9:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode paymentStatus: $data');
    }
  }

  static dynamic encode(PaymentStatus data) {
    return data.value;
  }
}
