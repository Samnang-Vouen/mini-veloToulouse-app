import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velotoulouse/data/config/firebase_config.dart';
import 'package:velotoulouse/data/dto/booking_dto.dart';
import 'package:velotoulouse/data/repositories/booking/booking_repository.dart';
import 'package:velotoulouse/model/booking/booking.dart';

class BookingRepositoryReal implements BookingRepository {
  static const String _userId = 'user_001';

  Uri get _bookingUri =>
      FirebaseConfig.baseUrl.replace(path: '/users/$_userId/booking.json');

  @override
  Future<Booking?> getActiveBooking() async {
    final response = await http.get(_bookingUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load booking (HTTP ${response.statusCode})');
    }

    if (response.body == 'null') return null;

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return BookingDto.fromJson(json);
  }

  @override
  Future<void> startBooking({
    required String stationId,
    required String dockId,
  }) async {
    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      stationId: stationId,
      dockId: dockId,
    );

    final response = await http.put(
      _bookingUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(BookingDto.toJson(booking)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save booking (HTTP ${response.statusCode})');
    }
  }

  @override
  Future<void> cancelBooking() async {
    final response = await http.delete(_bookingUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel booking (HTTP ${response.statusCode})');
    }
  }
}
