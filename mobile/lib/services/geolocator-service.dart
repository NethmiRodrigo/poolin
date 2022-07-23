import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  bool? serviceEnabled;
  late LocationPermission permission;

  Future<Position> getCurrentLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
