import 'package:geolocator/geolocator.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/position_entity.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<PositionResult> getCurrentPosition() async {
    try {
      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
        if (perm == LocationPermission.denied) {
          return (data: null, failure: PermissionFailure('Povolení polohy odepřeno'));
        }
      }
      if (perm == LocationPermission.deniedForever) {
        return (data: null, failure: PermissionFailure('Povolení polohy trvale odepřeno'));
      }
      if (!await Geolocator.isLocationServiceEnabled()) {
        return (data: null, failure: PermissionFailure('Služby polohy vypnuté'));
      }
      final p = await Geolocator.getCurrentPosition();
      return (data: PositionEntity(latitude: p.latitude, longitude: p.longitude), failure: null);
    } catch (e) {
      return (data: null, failure: UnknownFailure(e.toString()));
    }
  }
}