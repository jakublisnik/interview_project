import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_project/ui/screens/home_screen.dart';
import '../features/stations/data/datasources/station_local_datasource.dart';
import '../features/stations/domain/usecases/get_nearest_stations.dart';
import '../features/stations/presentation/bloc/station_bloc.dart';
import '../features/stations/presentation/bloc/station_event.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StationBloc(StationLocalDataSource(), GetNearestStations())..add(LoadStations()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Stations",
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
