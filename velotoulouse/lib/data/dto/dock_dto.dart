import 'package:velotoulouse/model/docks/dock.dart';

class DockDto {
  static final String idKey = 'id';
  static final String bikeKey = 'bike';

  static Dock fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);

    return Dock(
      id: json[idKey] as String,
      bike: json[bikeKey] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson(Dock dock) {
    return {idKey: dock.id, bikeKey: dock.bike};
  }
}
