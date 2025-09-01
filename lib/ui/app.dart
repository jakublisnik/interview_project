import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/stations/data/datasources/station_remote_data_source.dart';
import '../features/stations/data/datasources/station_local_data_source.dart';
import '../features/stations/data/repositories/station_repository_impl.dart';
import '../features/stations/data/repositories/location_repository_impl.dart';
import '../features/stations/domain/usecases/get_stations.dart';
import '../features/stations/domain/usecases/get_nearest_stations.dart';
import '../features/stations/domain/usecases/get_current_position.dart';
import '../features/stations/domain/usecases/search_stations.dart';
import '../features/stations/presentation/bloc/station_bloc.dart';
import '../features/stations/presentation/bloc/station_event.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  StationBloc _buildBloc() {
    final remote = StationRemoteDataSourceImpl();
    final local = StationLocalDataSourceImpl();
    final stationRepo = StationRepositoryImpl(remote: remote, local: local);
    final locationRepo = LocationRepositoryImpl();

    return StationBloc(
      getStations: GetStationsUseCase(stationRepo),
      getNearestStations: const GetNearestStations(),
      getCurrentPosition: GetCurrentPositionUseCase(locationRepo),
      searchStations: SearchStationsUseCase(stationRepo),
    )..add(const LoadStations());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _buildBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stations',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}