import '../../domain/entities/station_entity.dart';

class StationModel extends StationEntity {
  const StationModel({
    required super.id,
    required super.name,
    required super.lat,
    required super.lon,
  });

  factory StationModel.fromMap(Map<String, dynamic> map) {
    return StationModel(
      id: map['Id'] is int ? map['Id'] : int.parse(map['Id'].toString()),
      name: map['Nazev'] ?? '',
      lat: (map['GPSxDouble'] as num?)?.toDouble() ?? 0.0,
      lon: (map['GPSyDouble'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
