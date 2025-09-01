import '../../domain/entities/station_entity.dart';

class StationModelRemote extends StationEntity {
  const StationModelRemote({
    required super.id,
    required super.name,
    required super.lat,
    required super.lon,
  });

  factory StationModelRemote.fromJson(Map<String, dynamic> json) => StationModelRemote(
    id: json['id'] as int,
    name: json['name'] as String,
    lat: (json['lat'] as num).toDouble(),
    lon: (json['lng'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'lat': lat,
    'lng': lon,
  };
}