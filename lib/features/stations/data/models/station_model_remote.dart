import '../../domain/entities/station_entity.dart';

class StationModelRemote extends StationEntity {
  const StationModelRemote({
    required super.id,
    required super.name,
    required super.lat,
    required super.lon,
  });

  factory StationModelRemote.fromJson(Map<String, dynamic> json) {
    double _num(dynamic v) {
      if (v == null) return 0;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v.replaceAll(',', '.')) ?? 0;
      return 0;
    }

    final lat = json['GPSxDouble'] ?? json['GPSx'];
    final lon = json['GPSyDouble'] ?? json['GPSy'];

    return StationModelRemote(
      id: json['Id'] is String
          ? int.tryParse(json['Id']) ?? 0
          : (json['Id'] ?? 0),
      name: (json['Nazev'] ?? '').toString(),
      lat: _num(lat),
      lon: _num(lon),
    );
  }
}