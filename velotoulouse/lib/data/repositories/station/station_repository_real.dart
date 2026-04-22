import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:velotoulouse/data/config/firebase_config.dart';
import 'package:velotoulouse/data/dto/station_dto.dart';
import 'package:velotoulouse/data/repositories/station/station_repository.dart';
import 'package:velotoulouse/model/station/station.dart';

class StationRepositoryReal implements StationRepository {
  final Uri _stationsUri = FirebaseConfig.baseUrl.replace(
    path: '/stations.json',
  );

  @override
  Future<List<Station>> getStations() async {
    final response = await http.get(_stationsUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load stations (HTTP ${response.statusCode})');
    }

    final decoded = jsonDecode(response.body);

    final List<MapEntry<String, dynamic>> entries;
    if (decoded is Map<String, dynamic>) {
      entries = decoded.entries.toList();
    } else if (decoded is List<dynamic>) {
      entries = decoded
          .whereType<Map<String, dynamic>>()
          .map((e) => MapEntry(e['id'] as String, e as dynamic))
          .toList();
    } else {
      throw Exception('Unexpected stations response format');
    }

    return entries.map((entry) {
      final stationMap = Map<String, dynamic>.from(
        entry.value as Map<String, dynamic>,
      );

      final docksRaw = stationMap[StationDto.docksKey];
      if (docksRaw is Map) {
        stationMap[StationDto.docksKey] = (docksRaw as Map<String, dynamic>)
            .values
            .toList();
      }
      return StationDto.fromJson(entry.key, stationMap);
    }).toList();
  }
}
