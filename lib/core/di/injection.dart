import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/stations/data/datasources/station_remote_data_source.dart';
import '../../features/stations/data/datasources/station_local_data_source.dart';
import '../../features/stations/data/repositories/station_repository_impl.dart';
import '../../features/stations/data/repositories/location_repository_impl.dart';

import '../../features/stations/domain/repositories/station_repository.dart';
import '../../features/stations/domain/repositories/location_repository.dart';

import '../../features/stations/domain/usecases/get_stations.dart';
import '../../features/stations/domain/usecases/search_stations.dart';
import '../../features/stations/domain/usecases/get_current_position.dart';
import '../../features/stations/domain/usecases/get_nearest_stations.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Remote JSON (statický soubor hostovaný na GitHub Pages)
  getIt.registerLazySingleton<StationRemoteDataSource>(
        () => StationRemoteDataSourceImpl(
      client: http.Client(),
      jsonUrl: Uri.parse(
        'https://jakublisnik.github.io/station_api/Bod.json',
      ),
    ),
  );

  // Lokal datasource
  getIt.registerLazySingleton<StationLocalDataSource>(() => StationLocalDataSourceImpl());

  // Repositories
  getIt.registerLazySingleton<StationRepository>(
        () => StationRepositoryImpl(remote: getIt(), local: getIt()),
  );
  getIt.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl());

  // Use cases
  getIt.registerFactory(() => GetStationsUseCase(getIt()));
  getIt.registerFactory(() => SearchStationsUseCase(getIt()));
  getIt.registerFactory(() => GetCurrentPositionUseCase(getIt()));
  getIt.registerFactory(() => const GetNearestStations());
}