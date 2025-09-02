import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/station_model_remote.dart';

abstract interface class StationRemoteDataSource {
  Future<List<StationModelRemote>> fetchStations();
}

class StationRemoteDataSourceImpl implements StationRemoteDataSource {
  final http.Client _client;
  final Uri _jsonUrl;

  StationRemoteDataSourceImpl({
    http.Client? client,
    required Uri jsonUrl,
  })  : _client = client ?? http.Client(),
        _jsonUrl = jsonUrl;

  @override
  Future<List<StationModelRemote>> fetchStations() async {
    final resp = await _client.get(_jsonUrl);
    if (resp.statusCode != 200) {
      throw HttpException('HTTP ${resp.statusCode}');
    }
    final body = resp.body;
    final decoded = json.decode(body);
    if (decoded is! List) {
      throw const FormatException('Kořen JSON není pole');
    }
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(StationModelRemote.fromJson)
        .toList();
  }
}