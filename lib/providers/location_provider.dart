import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../models/location_model.dart';

enum LocationStatus { initial, loading, loaded, denied, error }

class LocationProvider extends ChangeNotifier {
  final LocationService _locationService;

  LocationStatus status = LocationStatus.initial;
  LocationModel? currentLocation;
  String errorMessage = '';

  LocationProvider({required LocationService locationService})
    : _locationService = locationService;

  Future<void> fetchLocation() async {
    status = LocationStatus.loading;
    notifyListeners();

    try {
      final hasPermission = await _locationService.requestPermission();
      if (!hasPermission) {
        status = LocationStatus.denied;
        errorMessage = 'Quyền vị trí bị từ chối';
        notifyListeners();
        return;
      }

      final position = await _locationService.getCurrentPosition();
      final cityName = await _locationService.getCityFromCoords(
        position.latitude,
        position.longitude,
      );

      currentLocation = LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
        cityName: cityName,
      );
      status = LocationStatus.loaded;
      errorMessage = '';
    } catch (e) {
      status = LocationStatus.error;
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    }

    notifyListeners();
  }

  bool get hasLocation => currentLocation != null;
}
