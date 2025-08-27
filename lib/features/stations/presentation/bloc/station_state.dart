import '../../domain/entities/station_entity.dart';

enum StationStatus { initial, loading, success, failure }

class StationState {
  final StationStatus status;
  final List<StationEntity> stations;
  final String? error;

  const StationState({
    this.status = StationStatus.initial,
    this.stations = const [],
    this.error,
  });

  StationState copyWith({
    StationStatus? status,
    List<StationEntity>? stations,
    String? error,
  }) {
    return StationState(
      status: status ?? this.status,
      stations: stations ?? this.stations,
      error: error ?? this.error,
    );
  }
}
