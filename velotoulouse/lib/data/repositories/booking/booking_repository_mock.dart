import 'package:velotoulouse/data/repositories/booking/booking_repository.dart';
import 'package:velotoulouse/model/booking/booking.dart';

class BookingRepositoryMock implements BookingRepository {
  Booking? _activeBooking;

  @override
  Future<Booking?> getActiveBooking() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _activeBooking;
  }

  @override
  Future<void> startBooking({
    required String stationId,
    required String dockId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _activeBooking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      stationId: stationId,
      dockId: dockId,
    );
  }

  @override
  Future<void> cancelBooking() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _activeBooking = null;
  }
}
