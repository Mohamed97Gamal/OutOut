class IssueTypes {
  /// The underlying value of this enum member.
  int value = 0;

  IssueTypes._internal(this.value);

  static IssueTypes Unspecified_ = IssueTypes._internal(0);
  static IssueTypes Listing_contains_bad_language_ = IssueTypes._internal(1);
  static IssueTypes Listing_contains_nudity_ = IssueTypes._internal(2);
  static IssueTypes Listing_contains_racism_or_other_prejudices_ = IssueTypes._internal(3);
  static IssueTypes Listing_contains_copyright_trademarks_ = IssueTypes._internal(4);
  static IssueTypes Listing_does_not_meet_the_Terms_and_Conditions_ = IssueTypes._internal(5);
  static IssueTypes Listing_is_against_UAE_Laws_ = IssueTypes._internal(6);
  static IssueTypes Listing_is_abusive_or_harmful_ = IssueTypes._internal(7);
  static IssueTypes Listing_is_defamatory_ = IssueTypes._internal(8);
  static IssueTypes Listing_promotes_hate_speech_ = IssueTypes._internal(9);
  static IssueTypes Listing_is_listed_more_than_once_ = IssueTypes._internal(10);
  static IssueTypes Listing_is_not_real_or_expired_ = IssueTypes._internal(11);
  static IssueTypes Listing_is_of_a_political_agenda_ = IssueTypes._internal(12);
  static IssueTypes The_image_is_inappropriate_ = IssueTypes._internal(13);
  static IssueTypes The_image_quality_is_poor_ = IssueTypes._internal(14);
  static IssueTypes The_information_is_incorrect_ = IssueTypes._internal(15);
  static IssueTypes The_App_is_not_working_ = IssueTypes._internal(16);
  static IssueTypes Can_I_request_a_refund_ = IssueTypes._internal(17);
  static IssueTypes My_offers_are_not_working_ = IssueTypes._internal(18);
  static IssueTypes My_app_is_not_updating_ = IssueTypes._internal(19);
  static IssueTypes Help_I_have_a_payment_issue_ = IssueTypes._internal(20);
  static IssueTypes Just_want_to_say_hello_ = IssueTypes._internal(21);

  static final List<IssueTypes> availableValues = [
    Unspecified_,
    Listing_contains_bad_language_,
    Listing_contains_nudity_,
    Listing_contains_racism_or_other_prejudices_,
    Listing_contains_copyright_trademarks_,
    Listing_does_not_meet_the_Terms_and_Conditions_,
    Listing_is_against_UAE_Laws_,
    Listing_is_abusive_or_harmful_,
    Listing_is_defamatory_,
    Listing_promotes_hate_speech_,
    Listing_is_listed_more_than_once_,
    Listing_is_not_real_or_expired_,
    Listing_is_of_a_political_agenda_,
    The_image_is_inappropriate_,
    The_image_quality_is_poor_,
    The_information_is_incorrect_,
    The_App_is_not_working_,
    Can_I_request_a_refund_,
    My_offers_are_not_working_,
    My_app_is_not_updating_,
    Help_I_have_a_payment_issue_,
    Just_want_to_say_hello_,
  ];

  String get name {
    switch (value) {
      case 0:
        return "Unspecified";
      case 1:
        return "Listing contains bad language";
      case 2:
        return "Listing contains nudity";
      case 3:
        return "Listing contains racism or other prejudices";
      case 4:
        return "Listing contains copyright trademarks";
      case 5:
        return "Listing does not meet the Terms and Conditions";
      case 6:
        return "Listing is against UAE Laws";
      case 7:
        return "Listing is abusive or harmful";
      case 8:
        return "Listing is defamatory";
      case 9:
        return "Listing promotes hate speech";
      case 10:
        return "Listing is listed more than once";
      case 11:
        return "Listing is not real or expired";
      case 12:
        return "Listing is of a political agenda";
      case 13:
        return "The image is inappropriate";
      case 14:
        return "The image quality is poor";
      case 15:
        return "The information is incorrect";
      case 16:
        return "The App is not working";
      case 17:
        return "Can I request a refund";
      case 18:
        return "My offers are not working";
      case 19:
        return "My app is not updating";
      case 20:
        return "Help I have a payment issue";
      case 21:
        return "Just want to say hello";
      default:
        throw ('Unknown enum value to decode $value');
    }
  }

  IssueTypes.fromJson(dynamic data) {
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
      case 10:
        value = data;
        break;
      case 11:
        value = data;
        break;
      case 12:
        value = data;
        break;
      case 13:
        value = data;
        break;
      case 14:
        value = data;
        break;
      case 15:
        value = data;
        break;
      case 16:
        value = data;
        break;
      case 17:
        value = data;
        break;
      case 18:
        value = data;
        break;
      case 19:
        value = data;
        break;
      case 20:
        value = data;
        break;
      case 21:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode Issue Types: $data');
    }
  }

  static dynamic encode(IssueTypes data) {
    return data.value;
  }
}
