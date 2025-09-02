import '../entities/station_entity.dart';

class GetNearestStations {
  const GetNearestStations();

  List<StationEntity> call({
    required List<StationEntity> all,
    required double lat,
    required double lon,
    int limit = 3,
  }) {
    final sorted = List<StationEntity>.from(all)
      ..sort((a, b) => _dist(a, lat, lon).compareTo(_dist(b, lat, lon)));
    return sorted.take(limit).toList();
  }

  double _dist(StationEntity s, double lat, double lon) {
    final dx = s.lat - lat;
    final dy = s.lon - lon;
    return dx * dx + dy * dy;
  }
}