import '../../../../core/error/failure.dart';
import '../entities/station_entity.dart';

typedef StationResult = ({List<StationEntity> data, Failure? failure});

abstract interface class StationRepository {
  Future<StationResult> getStations({bool forceRefresh});
  Future<StationResult> searchStations(String query);
}