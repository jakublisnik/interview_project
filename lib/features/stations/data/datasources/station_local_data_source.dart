import 'package:interview_project/features/stations/data/models/station_model_remote.dart';

abstract interface class StationLocalDataSource {
  Future<List<StationModelRemote>> readStations();
  Future<void> writeStations(List<StationModelRemote> stations);
  Future<List<StationModelRemote>> search(String query);
}

class StationLocalDataSourceImpl implements StationLocalDataSource {
  List<StationModelRemote> _cache = [];

  @override
  Future<List<StationModelRemote>> readStations() async => _cache;

  @override
  Future<void> writeStations(List<StationModelRemote> stations) async {
    _cache = stations;
  }

  @override
  Future<List<StationModelRemote>> search(String query) async {
    final q = query.toLowerCase();
    return _cache.where((s) => s.name.toLowerCase().contains(q)).toList();
  }
}