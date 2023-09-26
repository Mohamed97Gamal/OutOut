abstract class HeroTagHelper {
  HeroTagHelper._();

  static String organizationImage(String id) {
    return "org_picture_$id";
  }

  static String userImage(String id) {
    return "user_picture_$id";
  }
}
