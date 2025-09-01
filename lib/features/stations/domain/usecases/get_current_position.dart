import '../repositories/location_repository.dart';

class GetCurrentPositionUseCase {
  final LocationRepository _repo;
  const GetCurrentPositionUseCase(this._repo);

  Future<PositionResult> call() => _repo.getCurrentPosition();
}