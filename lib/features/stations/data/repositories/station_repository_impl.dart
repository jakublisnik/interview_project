import 'dart:io';
import '../../../../core/error/failure.dart';
import '../../domain/entities/station_entity.dart';
import '../../domain/repositories/station_repository.dart';
import '../datasources/station_remote_data_source.dart';
import '../datasources/station_local_data_source.dart';


class StationRepositoryImpl implements StationRepository {
  final StationRemoteDataSource remote;
  final StationLocalDataSource local;

  StationRepositoryImpl({required this.remote, required this.local});

  @override
  Future<StationResult> getStations({bool forceRefresh = false}) async {
    try {
      if (!forceRefresh) {
        final cached = await local.readStations(); // List<StationModel>
        if (cached.isNotEmpty) {
          return (data: cached.cast<StationEntity>(), failure: null);
        }
      }
      final remoteData = await remote.fetchStations(); // List<StationModel>
      await local.writeStations(remoteData);
      return (data: remoteData.cast<StationEntity>(), failure: null);
    } on SocketException {
      final cached = await local.readStations();
      if (cached.isNotEmpty) {
        return (
        data: cached.cast<StationEntity>(),
        failure: NetworkFailure('Offline, vrácena cache')
        );
      }
      return (data: const <StationEntity>[], failure: NetworkFailure('Síť nedostupná'));
    } catch (e) {
      return (data: const <StationEntity>[], failure: UnknownFailure(e.toString()));
    }
  }

  @override
  Future<StationResult> searchStations(String query) async {
    try {
      final list = await local.search(query); // List<StationModel>
      return (data: list.cast<StationEntity>(), failure: null);
    } catch (e) {
      return (data: const <StationEntity>[], failure: UnknownFailure(e.toString()));
    }
  }
}