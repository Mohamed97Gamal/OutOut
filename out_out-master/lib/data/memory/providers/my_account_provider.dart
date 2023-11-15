import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:out_out/data/view_models/auth/application_user_response.dart';
import 'package:out_out/widgets/loading/future_builder.dart';

class MyAccountProvider with ChangeNotifier, DiagnosticableTreeMixin {
  RefreshNotifier refreshNotifier = RefreshNotifier();
  RefreshNotifier favoriteVenuesRefreshNotifier = RefreshNotifier();
  RefreshNotifier favoriteEventsRefreshNotifier = RefreshNotifier();
  RefreshNotifier venueBookingsRefreshNotifier = RefreshNotifier();
  RefreshNotifier eventBookingsRefreshNotifier = RefreshNotifier();
  RefreshNotifier venueLoyaltyRefreshNotifier = RefreshNotifier();
    RefreshNotifier myOffersRefreshNotifier = RefreshNotifier();


  bool firstTimeLogin = false;
  ApplicationUserResponse? _applicationUserResponse;

  ApplicationUserResponse get applicationUserResponse => _applicationUserResponse!;

  void update(ApplicationUserResponse application_user_response, {bool firstTime = false}) {
    _applicationUserResponse = application_user_response;
    firstTimeLogin = firstTime;
    refreshNotifier.refresh();
    notifyListeners();
  }

  void reset() {
    _applicationUserResponse = null;
    refreshNotifier.refresh();
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('applicationUserResponse', _applicationUserResponse.toString()));
  }
}
