import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/injection.dart';
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
    return StationBloc(
      getStations: getIt<GetStationsUseCase>(),
      getNearestStations: getIt<GetNearestStations>(),
      getCurrentPosition: getIt<GetCurrentPositionUseCase>(),
      searchStations: getIt<SearchStationsUseCase>(),
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