import 'package:velotoulouse/data/dto/dock_dto.dart';
import 'package:velotoulouse/model/station/station.dart';

class StationDto {
  static final String nameKey = 'name';
  static final String streetNameKey = 'streetName';
  static final String latitudeKey = 'latitude';
  static final String longitudeKey = 'longitude';
  static final String docksKey = 'docks';

  static Station fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[streetNameKey] is String);
    assert(json[latitudeKey] is num);
    assert(json[longitudeKey] is num);
    assert(json[docksKey] is List);

    return Station(
      id: id,
      name: json[nameKey] as String,
      streetName: json[streetNameKey] as String,
      latitude: (json[latitudeKey] as num).toDouble(),
      longitude: (json[longitudeKey] as num).toDouble(),
      dock: (json[docksKey] as List<dynamic>)
          .map((d) => DockDto.fromJson(d as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson(Station station) {
    return {
      nameKey: station.name,
      streetNameKey: station.streetName,
      latitudeKey: station.latitude,
      longitudeKey: station.longitude,
      docksKey: station.dock.map((d) => DockDto().toJson(d)).toList(),
    };
  }
}
