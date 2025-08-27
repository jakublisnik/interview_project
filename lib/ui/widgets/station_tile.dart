import 'package:flutter/material.dart';
import '../../features/stations/domain/entities/station_entity.dart';

class StationTile extends StatelessWidget {
  final StationEntity station;
  final double? distanceKm;

  const StationTile({
    super.key,
    required this.station,
    this.distanceKm,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(station.name),
      subtitle: Text('Lat: ${station.lat}, Lon: ${station.lon}'),
      leading: Icon(Icons.location_pin),
      trailing: distanceKm != null
          ? Text('${distanceKm!.toStringAsFixed(2)} km',
          style: const TextStyle(fontSize: 12))
          : null,
    );
  }
}