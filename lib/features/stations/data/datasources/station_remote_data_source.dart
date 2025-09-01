import '../models/station_model_remote.dart';

abstract interface class StationRemoteDataSource {
  Future<List<StationModelRemote>> fetchStations();
}

class StationRemoteDataSourceImpl implements StationRemoteDataSource {
  @override
  Future<List<StationModelRemote>> fetchStations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      StationModelRemote(id: 1, name: 'Alpha', lat: 1, lon: 1),
      StationModelRemote(id: 2, name: 'Beta', lat: 2, lon: 2),
    ];
  }
}