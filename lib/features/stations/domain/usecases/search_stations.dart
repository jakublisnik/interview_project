import '../repositories/station_repository.dart';

class SearchStationsUseCase {
  final StationRepository _repo;
  const SearchStationsUseCase(this._repo);

  Future<StationResult> call(String query) => _repo.searchStations(query);
}