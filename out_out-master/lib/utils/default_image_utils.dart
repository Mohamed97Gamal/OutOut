import 'package:out_out/assets/image_assets.dart';
import 'package:out_out/utils/common.dart';

getAvatarUri(String? avatar) {
  return firstNotNullOrEmpty(avatar, ImageAssets.defaultAvatar);
}

getCategoryUri(String? category) {
  return firstNotNullOrEmpty(category, ImageAssets.defaultCategory);
}

getVenueUri(String? venue) {
  return firstNotNullOrEmpty(venue, ImageAssets.defaultVenue);
}

getEventUri(String? event) {
  return firstNotNullOrEmpty(event, ImageAssets.defaultEvent);
}

getVenueBackgroundUri(String? venueBackground) {
  return firstNotNullOrEmpty(venueBackground, ImageAssets.defaultVenueBackground);
}

getEventBackgroundUri(String? eventBackground) {
  return firstNotNullOrEmpty(eventBackground, ImageAssets.defaultEventBackground);
}

getDealUri(String? deal) {
  return firstNotNullOrEmpty(deal, ImageAssets.defaultDeal);
}

getNotificationUri(String? notification) {
  return firstNotNullOrEmpty(notification, ImageAssets.defaultNotification);
}

