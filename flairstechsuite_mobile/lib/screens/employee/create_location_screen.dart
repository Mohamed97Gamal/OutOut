import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateLocationScreen extends StatefulWidget {
  @override
  _CreateLocationScreenState createState() => _CreateLocationScreenState();
}

class _CreateLocationScreenState extends State<CreateLocationScreen> {
  final _nameFieldKey = GlobalKey<FormFieldState>();
  var createLocationViewModel = CreateLocationViewModel();
  String? _locationValidationText;
  final _refreshableKey = GlobalKey<RefreshableState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return NotificationScaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Location".toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextFormField(
                key: _nameFieldKey,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  labelText: "Location Name*",
                  labelStyle: TextStyle(
                      color: Colors.grey
                  ),
                ),
                onChanged: (s) => createLocationViewModel =
                    createLocationViewModel.copyWith(name: s),
                validator: (s) {
                  {
                    {
                      if ((s != null && s.isNotEmpty)) {
                        if ((s.length <= 50)) {
                          return null;
                        } else {
                          return "must be between 0 and 50.";
                        }
                      }
                      return "This field is required.";
                    }
                  }
                },
              ),
              const SizedBox(height: 8),
               SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: InputDecorator(
                  decoration: InputDecoration(
                    errorText: _locationValidationText,
                  ),
                  child: Refreshable(
                    key: _refreshableKey,
                    child: CustomFutureBuilder(
                      initFuture: () => _checkLocationServiceAndPermission(),
                      onSuccess: (_, snapshot) {
                        switch (snapshot.data) {
                          case 0:
                            return _buildMap();
                          case 1:
                          case 2:
                            return _offlineUI();
                          case 3:
                            return _offlineUI(
                                message:
                                    "Location Denied Forever,\nPlease allow the app to use your location from the app settings");
                        }
                        return _offlineUI();
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: Text("Save Location".toUpperCase()),
                onPressed: _onSaveLocation,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> _checkLocationServiceAndPermission() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) return 1;

    final permissionResult = await Geolocator.checkPermission();
    if (permissionResult == LocationPermission.whileInUse ||
        permissionResult == LocationPermission.always) return 0;

    final requestPermissionResult = await Geolocator.requestPermission();
    switch (requestPermissionResult) {
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        return 0;
      case LocationPermission.denied:
        return 2;
      case LocationPermission.deniedForever:
        return 3;
      default:
        return -1;
    }
  }

  Widget _offlineUI({String? message}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () {
          _refreshableKey.currentState!.refresh();
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.gps_off, size: 50),
              const SizedBox(height: 12.0),
              Text(
                message ?? "Check your GPS settings",
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Tap to retry",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return CustomFutureBuilder<Position>(
      initFuture: () => Geolocator.getCurrentPosition(),
      onError: (context, _) => _offlineUI(),
      onSuccess: (context, snapshot) {
        createLocationViewModel = createLocationViewModel.copyWith(
          latitude: createLocationViewModel.latitude ?? snapshot.data!.latitude,
          longitude:
              createLocationViewModel.longitude ?? snapshot.data!.longitude,
        );
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 3.0,
          child: GoogleMap(
            myLocationButtonEnabled: false,
            gestureRecognizers: {
              Factory(() => EagerGestureRecognizer()),
            },
            initialCameraPosition: CameraPosition(
              zoom: 20.0,
              target: LatLng(createLocationViewModel.latitude!,
                  createLocationViewModel.longitude!),
            ),
            onTap: (position) {
              setState(() {
                createLocationViewModel = createLocationViewModel.copyWith(
                  latitude: position.latitude,
                  longitude: position.longitude,
                );
              });
            },
            markers: {
              Marker(
                markerId: MarkerId("Current"),
                position: LatLng(
                  createLocationViewModel.latitude!,
                  createLocationViewModel.longitude!,
                ),
              ),
            },
          ),
        );
      },
    );
  }

  _onSaveLocation() async {
    if (createLocationViewModel.latitude == null ||
        createLocationViewModel.longitude == null) {
      setState(() {
        _locationValidationText = "Location is required.";
      });
      if (!_nameFieldKey.currentState!.validate()) {
        // ignore: deprecated_member_use
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Please fix the errors in red before submitting.")),
        );
        return;
      }
      return;
    }

    if (_locationValidationText != null)
      setState(() {
        _locationValidationText = null;
      });

    if (!_nameFieldKey.currentState!.validate()) {
      // ignore: deprecated_member_use
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fix the errors in red before submitting.")),
      );
      return;
    }

    final response = await showFutureProgressDialog<LocationDTOResponse>(
      context: context,
      initFuture: () => Repository().createLocation(createLocationViewModel),
    );
    if (response?.status ?? false) {
      await showAdaptiveAlertDialog(
        context: context,
        content: const Text("You have successfully added new location."),
      );
      Navigator.of(context).pop(true);
    } else {
      await showErrorDialog(context, response);
    }
  }
}
