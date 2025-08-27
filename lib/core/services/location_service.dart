import 'package:geolocator/geolocator.dart';

class LocationResult {
  final Position? position;
  final bool serviceDisabled;
  final bool denied;
  final bool deniedForever;

  const LocationResult({
    required this.position,
    required this.serviceDisabled,
    required this.denied,
    required this.deniedForever,
  });

  bool get granted => position != null;
}

class LocationService {
  Future<LocationResult> fetch() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const LocationResult(
        position: null,
        serviceDisabled: true,
        denied: false,
        deniedForever: false,
      );
    }

    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }

    if (perm == LocationPermission.denied) {
      return const LocationResult(
        position: null,
        serviceDisabled: false,
        denied: true,
        deniedForever: false,
      );
    }

    if (perm == LocationPermission.deniedForever) {
      return const LocationResult(
        position: null,
        serviceDisabled: false,
        denied: false,
        deniedForever: true,
      );
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    return LocationResult(
      position: pos,
      serviceDisabled: false,
      denied: false,
      deniedForever: false,
    );
  }

  Future<void> openAppSettings() => Geolocator.openAppSettings();

  Future<void> openLocationSettings() => Geolocator.openLocationSettings();
}