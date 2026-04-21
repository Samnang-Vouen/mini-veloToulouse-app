import 'package:flutter/material.dart';
import 'package:velotoulouse/data/repositories/user/user_repository.dart';
import 'package:velotoulouse/model/booking/booking.dart';
import 'package:velotoulouse/model/user/user.dart';
import 'package:velotoulouse/model/user/user_subscription.dart';

class UserState extends ChangeNotifier {
  final UserRepository _userRepository;
  final BookingRepository _bookingRepository;

  User? _user;

  User? get user => _user;

  UserState({
    required UserRepository userRepository,
    required BookingRepository bookingRepository,
  }) : _userRepository = userRepository,
       _bookingRepository = bookingRepository {
    _init();
  }

  Future<void> _init() async {
    final fetchedUser = await _userRepository.getUser();
    final booking = await _bookingRepository.getActiveBooking();
    _user = fetchedUser?.copyWith(
      bookings: booking != null ? [booking] : const [],
    );
    notifyListeners();
  }

  Future<void> refreshSubscription() async {
    final sub = await _userRepository.getActiveSubscription();
    if (_user != null) {
      _user = User(
        id: _user!.id,
        name: _user!.name,
        email: _user!.email,
        subscription: sub,
        bookings: _user!.bookings,
      );
    }
    notifyListeners();
  }

  Future<void> refreshBooking() async {
    final booking = await _bookingRepository.getActiveBooking();
    if (_user != null) {
      _user = User(
        id: _user!.id,
        name: _user!.name,
        email: _user!.email,
        subscription: _user!.subscription,
        bookings: booking != null ? [booking] : const [],
      );
    }
    notifyListeners();
  }

  void clearBooking() {
    if (_user != null) {
      _user = User(
        id: _user!.id,
        name: _user!.name,
        email: _user!.email,
        subscription: _user!.subscription,
        bookings: const [],
      );
    }
    notifyListeners();
  }
}
