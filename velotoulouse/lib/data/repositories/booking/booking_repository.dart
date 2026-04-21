import 'package:velotoulouse/model/booking/booking.dart';

abstract class BookingRepository {
  Future<Booking?> getActiveBooking();
  Future<void> startBooking({
    required String stationId,
    required String dockId,
  });
  Future<void> cancelBooking();
}
