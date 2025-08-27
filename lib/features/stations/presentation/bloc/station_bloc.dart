import 'package:flutter_bloc/flutter_bloc.dart';
import 'station_event.dart';
import 'station_state.dart';
import '../../domain/usecases/get_nearest_stations.dart';
import '../../data/datasources/station_local_datasource.dart';
import 'package:geolocator/geolocator.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  final StationLocalDataSource dataSource;
  final GetNearestStations getNearestStations;

  StationBloc(this.dataSource, this.getNearestStations) : super(const StationState()) {
    on<LoadStations>(_onLoadStations);
    on<SearchStations>(_onSearchStations);
  }

  Future<void> _onLoadStations(LoadStations event, Emitter<StationState> emit) async {
    emit(state.copyWith(status: StationStatus.loading));
    try {
      final all = await dataSource.getAllStations();
      final pos = await Geolocator.getCurrentPosition();
      final nearest = getNearestStations(all: all, lat: pos.latitude, lon: pos.longitude);
      emit(state.copyWith(status: StationStatus.success, stations: nearest));
    } catch (e) {
      emit(state.copyWith(status: StationStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onSearchStations(SearchStations event, Emitter<StationState> emit) async {
    if (event.query.length < 3) return;
    emit(state.copyWith(status: StationStatus.loading));
    try {
      final results = await dataSource.searchStations(event.query);
      emit(state.copyWith(status: StationStatus.success, stations: results));
    } catch (e) {
      emit(state.copyWith(status: StationStatus.failure, error: e.toString()));
    }
  }
}
