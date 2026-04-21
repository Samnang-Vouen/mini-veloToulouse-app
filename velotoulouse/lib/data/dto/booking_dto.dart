import 'package:velotoulouse/model/booking/booking.dart';

class BookingDto {
  static final String idKey = 'id';
  static final String stationIdKey = 'stationId';
  static final String dockIdKey = 'dockId';

  static Booking fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[stationIdKey] is String);
    assert(json[dockIdKey] is String);

    return Booking(
      id: json[idKey] as String,
      stationId: json[stationIdKey] as String,
      dockId: json[dockIdKey] as String,
    );
  }

  static Map<String, dynamic> toJson(Booking booking) {
    return {
      idKey: booking.id,
      stationIdKey: booking.stationId,
      dockIdKey: booking.dockId,
    };
  }
}
