import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_stations.dart';
import '../../domain/usecases/get_nearest_stations.dart';
import '../../domain/usecases/get_current_position.dart';
import '../../domain/usecases/search_stations.dart';
import 'station_event.dart';
import 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  final GetStationsUseCase _getStations;
  final GetNearestStations _getNearestStations;
  final GetCurrentPositionUseCase _getCurrentPosition;
  final SearchStationsUseCase _searchStations;

  StationBloc({
    required GetStationsUseCase getStations,
    required GetNearestStations getNearestStations,
    required GetCurrentPositionUseCase getCurrentPosition,
    required SearchStationsUseCase searchStations,
  })  : _getStations = getStations,
        _getNearestStations = getNearestStations,
        _getCurrentPosition = getCurrentPosition,
        _searchStations = searchStations,
        super(const StationState()) {
    on<LoadStations>(_onLoadStations);
    on<SearchStations>(_onSearchStations);
  }

  Future<void> _onLoadStations(
      LoadStations event,
      Emitter<StationState> emit,
      ) async {
    emit(state.copyWith(status: StationStatus.loading, error: null));

    final stationsResult = await _getStations(forceRefresh: event.forceRefresh);
    if (stationsResult.failure != null) {
      _emitFailure(emit, stationsResult.failure!.message);
      return;
    }

    final positionResult = await _getCurrentPosition();
    if (positionResult.failure != null) {
      _emitFailure(emit, positionResult.failure!.message);
      return;
    }

    final nearest = _getNearestStations(
      all: stationsResult.data,
      lat: positionResult.data!.latitude,
      lon: positionResult.data!.longitude,
    );

    emit(state.copyWith(
      status: StationStatus.success,
      stations: nearest,
      error: null,
    ));
  }

  Future<void> _onSearchStations(
      SearchStations event,
      Emitter<StationState> emit,
      ) async {
    final q = event.query.trim();
    if (q.length < 3) return;

    emit(state.copyWith(status: StationStatus.loading, error: null));
    final result = await _searchStations(q);
    if (result.failure != null) {
      _emitFailure(emit, result.failure!.message);
      return;
    }
    emit(state.copyWith(
      status: StationStatus.success,
      stations: result.data,
      error: null,
    ));
  }

  void _emitFailure(Emitter<StationState> emit, String message) {
    emit(state.copyWith(status: StationStatus.failure, error: message));
  }
}