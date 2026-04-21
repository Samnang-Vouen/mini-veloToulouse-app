import 'package:flutter/material.dart';
import 'package:velotoulouse/data/repositories/booking/booking_repository.dart';
import 'package:velotoulouse/data/repositories/user/user_repository.dart';
import 'package:velotoulouse/model/user/user.dart';

class UserState extends ChangeNotifier {
  final UserRepository _userRepository;
  final BookingRepository _bookingRepository;

  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  UserState({
    required UserRepository userRepository,
    required BookingRepository bookingRepository,
  }) : _userRepository = userRepository,
       _bookingRepository = bookingRepository {
    _init();
  }

  Future<void> _init() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final fetchedUser = await _userRepository.getUser();
      final booking = await _bookingRepository.getActiveBooking();
      _user = fetchedUser?.copyWith(
        bookings: booking != null ? [booking] : const [],
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshSubscription() async {
    final sub = await _userRepository.getActiveSubscription();
    if (sub == null && _user?.bookings.isNotEmpty == true) {
      await _bookingRepository.cancelBooking();
      _user = User(
        id: _user!.id,
        name: _user!.name,
        email: _user!.email,
        subscription: null,
        bookings: const [],
      );
    } else if (_user != null) {
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
      _user = _user!.copyWith(bookings: booking != null ? [booking] : const []);
    }
    notifyListeners();
  }

  void clearBooking() {
    if (_user != null) {
      _user = _user!.copyWith(bookings: const []);
    }
    notifyListeners();
  }
}
