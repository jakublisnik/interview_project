abstract class StationEvent {
  const StationEvent();
}

class LoadStations extends StationEvent {
  final bool forceRefresh;
  const LoadStations({this.forceRefresh = false});
}

class SearchStations extends StationEvent {
  final String query;
  const SearchStations(this.query);
}