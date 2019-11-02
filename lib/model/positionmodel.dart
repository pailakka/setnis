import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

var locationOptions = LocationOptions(
    accuracy: LocationAccuracy.high,
    distanceFilter: 0,
    forceAndroidLocationManager: true);

class PositionModel with ChangeNotifier {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;

  StreamSubscription<Position> positionStream;

  Position get currentPosition => _currentPosition;

  PositionModel() {
    Geolocator()
        .checkGeolocationPermissionStatus()
        .then((GeolocationStatus geolocationStatus) {
      developer.log(geolocationStatus.toString(), name: 'geolocationStatus');
      if (geolocationStatus == GeolocationStatus.granted) {
        positionStream = geolocator
            .getPositionStream(locationOptions)
            .listen((Position position) {
          _currentPosition = position;
          notifyListeners();
        });
      }
    });
  }

  getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _currentPosition = position;
      notifyListeners();
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    positionStream.cancel().then((dynamic a) {
      super.dispose();
    });
  }
}
