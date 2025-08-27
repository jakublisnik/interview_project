import '../../../../core/utils/distance.dart';
import '../entities/station_entity.dart';

class GetNearestStations {
  List<StationEntity> call({
    required List<StationEntity> all,
    required double lat,
    required double lon,
    int limit = 3,
  }) {
    final withDist = all.map((s) => MapEntry(
      s,
      distanceMeters(lat, lon, s.lat, s.lon),
    )).toList();

    withDist.sort((a, b) => a.value.compareTo(b.value));
    return withDist.take(limit).map((e) => e.key).toList();
  }
}
