import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  // Xin quyen vi tri, tra ve true neu duoc cap
  Future<bool> requestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) return false;

    return true;
  }

  // Lay toa do hien tai
  Future<Position> getCurrentPosition() async {
    final hasPermission = await requestPermission();
    if (!hasPermission) {
      throw Exception(
        'Không có quyền truy cập vị trí.\nVui lòng bật GPS và cấp quyền cho ứng dụng.',
      );
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );
  }

  // Lay ten thanh pho tu toa do (reverse geocoding)
  Future<String> getCityFromCoords(double lat, double lon) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        return placemarks[0].locality ??
            placemarks[0].administrativeArea ??
            'Unknown';
      }
      return 'Unknown';
    } catch (e) {
      return 'Unknown';
    }
  }
}
