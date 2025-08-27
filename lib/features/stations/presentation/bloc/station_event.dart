abstract class StationEvent {}

class LoadStations extends StationEvent {}

class SearchStations extends StationEvent {
  final String query;
  SearchStations(this.query);
}
