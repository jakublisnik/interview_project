import '../repositories/station_repository.dart';

class GetStationsUseCase {
  final StationRepository _repo;
  const GetStationsUseCase(this._repo);

  Future<StationResult> call({bool forceRefresh = false}) =>
      _repo.getStations(forceRefresh: forceRefresh);
}