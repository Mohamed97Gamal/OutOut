import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/assets/image_assets.dart';
import 'package:out_out/assets/json_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/api/geocoding_repo.dart';
import 'package:out_out/data/api/places_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/view_models/auth/application_user_response_operation_result.dart';
import 'package:out_out/data/view_models/user_location_request.dart';
import 'package:out_out/utils/location_utils.dart';
import 'package:out_out/widgets/containers/custom_scaffold.dart';
import 'package:out_out/widgets/loading/adaptive_progress_indicator.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class ChangeLocationScreen extends StatefulWidget {
  const ChangeLocationScreen({Key? key}) : super(key: key);

  @override
  _ChangeLocationScreenState createState() => _ChangeLocationScreenState();
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen> {
  RefreshNotifier refreshNotifier = RefreshNotifier();

  late String selectedName;
  late LatLng selectedLatLng;
  GoogleMapController? mapController;
  bool firstGoogleMapsCreated = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var myAccountProvider = context.read<MyAccountProvider>();
    final location = myAccountProvider.applicationUserResponse.location;

    selectedName = location.description;
    selectedLatLng =
        LatLng(location.latitude.toDouble(), location.longitude.toDouble());
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      headerHeight: MediaQuery.of(context).size.height * 0.7,
      headerBodyOverlapHeight: 40.0,
      showChangeLocation: false,
      header: Refreshable(
        refreshNotifier: refreshNotifier,
        child: CustomFutureBuilder<List>(
          initFuture: () async {
            var result = [];
            var bytes = await getBytesFromAsset(ImageAssets.location_pin, 400);
            if (bytes != null) {
              result.add(BitmapDescriptor.fromBytes(bytes));
            }

            result
                .add(await rootBundle.loadString(JsonAssets.google_maps_style));

            return result;
          },
          onSuccess: (context, snapshot) {
            var markerIconBitmapDescriptor =
                snapshot.data?.elementAt(0) as BitmapDescriptor;
            var styleString = snapshot.data?.elementAt(1) as String;
            return Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  tiltGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  buildingsEnabled: false,
                  onMapCreated: (controller) async {
                    setState(() {
                      mapController = controller;
                      mapController!.setMapStyle(styleString);
                    });
                    if (firstGoogleMapsCreated) {
                      firstGoogleMapsCreated = false;
                      await _handleCurrentLocation(context);
                    }
                  },
                  markers: <Marker>{
                    Marker(
                      markerId: MarkerId("selected_location"),
                      icon: markerIconBitmapDescriptor,
                      position: selectedLatLng,
                      anchor: Offset(0.5, 0.5),
                      flat: true,
                      onTap: null,
                    ),
                  },
                  onTap: (latlng) async {
                    await _handleLocationChanged(context, latlng);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  initialCameraPosition: CameraPosition(
                    zoom: 50.0,
                    target: LatLng(
                        selectedLatLng.latitude, selectedLatLng.longitude),
                  ),
                ),
                Positioned(
                  right: 20.0,
                  bottom: 50.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _handleCurrentLocation(context);
                    },
                    child: Text("Current Location"),
                  ),
                ),
                Positioned(
                  top: 62.0,
                  left: 16.0,
                  right: 16.0,
                  child: ChangeLocationSearchField(
                    onSelected: (latlng) =>
                        _handleLocationChanged(context, latlng),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bodyPadding: const EdgeInsets.all(20.0),
      body: ChangeLocationBottomSheet(
        selectedName: selectedName,
        selectedLatLng: selectedLatLng,
      ),
    );
  }

  bool changing = false;

  _handleCurrentLocation(BuildContext context) async {
    if (changing) return;
    changing = true;
    try {
      LatLng? latlng;
      final String? addressName = await showFutureProgressDialog<String?>(
        context: context,
        initFuture: () async {
          latlng = await getCurrentLocation(
            context,
            locationAccuracy: LocationAccuracy.high,
          );
          if (latlng == null) return null;

          var addressNameFuture = GeoCodingRepo()
              .getAddressName(latlng!.latitude, latlng!.longitude);
          await Future.wait(
            [
              addressNameFuture,
              Future.delayed(Duration(milliseconds: 600)),
            ],
          );
          return await addressNameFuture;
        },
      );
      if (latlng == null) {
        return;
      }
      if (addressName == null) {
        await showAdaptiveErrorDialog(
          context: context,
          title: "Unsupported Location",
          content: "Please select a location in 'United Arab Emirates'.",
        );
        return;
      }

      setState(() {
        selectedName = addressName;
        selectedLatLng = latlng!;
      });

      final cameraPosition = CameraPosition(target: latlng!, zoom: 20.0);
      await mapController!.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    } finally {
      changing = false;
    }
  }

  _handleLocationChanged(BuildContext context, LatLng? latlng) async {
    if (latlng == null) return;

    final String? addressName = await showFutureProgressDialog<String?>(
      context: context,
      initFuture: () async {
        Future<String?> addressNameFuture =
            GeoCodingRepo().getAddressName(latlng.latitude, latlng.longitude);
        await Future.wait(
          [
            addressNameFuture,
            Future.delayed(Duration(milliseconds: 600)),
          ],
        );
        return await addressNameFuture;
      },
    );
    if (addressName == null) {
      //TODO: handle no results from geocoding
      await showAdaptiveErrorDialog(
        context: context,
        title: "Unsupported Location",
        content: "Please select a location in 'United Arab Emirates'.",
      );
      return;
    }

    setState(() {
      selectedName = addressName;
      selectedLatLng = latlng;
    });

    final cameraPosition = CameraPosition(target: latlng, zoom: 20.0);
    await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }
}

class ChangeLocationBottomSheet extends StatelessWidget {
  const ChangeLocationBottomSheet({
    Key? key,
    required this.selectedName,
    required this.selectedLatLng,
  }) : super(key: key);

  final String selectedName;
  final LatLng selectedLatLng;

  @override
  Widget build(BuildContext context) {
    MyAccountProvider myAccountProvider = context.read<MyAccountProvider>();
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleText("Set Your Location"),
          const SizedBox(height: 16.0),
          Text("Your current location is near $selectedName."),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              child: Text("Confirm Location"),
              onPressed: () async {
                var userInfoResult = await showFutureProgressDialog<
                    ApplicationUserResponseOperationResult>(
                  context: context,
                  initFuture: () {
                    final request = new UserLocationRequest()
                      ..latitude = selectedLatLng.latitude
                      ..longitude = selectedLatLng.longitude
                      ..description = selectedName;
                    return ApiRepo()
                        .customersClient
                        .updateUserLocation(request);
                  },
                );
                if (userInfoResult != null && userInfoResult.status) {
                  myAccountProvider.update(userInfoResult.result);
                  await showAdaptiveAlertDialog(
                    context: context,
                    icon: UniversalImage(IconAssets.done),
                    content: "You have set the location successfully.",
                    showCloseButton: false,
                  );
                  Navigator.of(context).maybePop();
                } else {
                  await showAdaptiveErrorDialog(
                    context: context,
                    title: "Error",
                    content: userInfoResult?.errorMessage ?? "Unknown Error",
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChangeLocationSearchField extends StatelessWidget {
  final ValueChanged<LatLng> onSelected; 
  const ChangeLocationSearchField({
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      viewportBuilder: (BuildContext context, ViewportOffset position) => Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 3.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              UniversalImage(
                IconAssets.search,
                width: 20.0,
                height: 20.0,
              ),
              Expanded(
                child: TypeAheadField<PlacesSearchResult>(
                  debounceDuration: Duration(milliseconds: 500),
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      fillColor: Colors.white,
                      hintText: "Search Location",
                      hintStyle: TextStyle(
                        color: Color(0xffd5d5d5),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    await Future.delayed(Duration(milliseconds: 400));
                    return PlacesRepo().searchByText(pattern);
                  },
                  keepSuggestionsOnLoading: false,
                  loadingBuilder: (context) {
                    return const SizedBox(
                      height: 60.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: AdaptiveProgressIndicator(),
                        ),
                      ),
                    );
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion.name),
                      subtitle: Text(suggestion.formattedAddress!),
                    );
                  },
                  onSuggestionSelected: (suggestion) async {
                    //TODO: show progress dialog
                    onSelected(
                      LatLng(suggestion.geometry!.location.lat,
                          suggestion.geometry!.location.lng),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
