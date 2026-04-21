import 'package:flutter/material.dart';
import 'package:velotoulouse/data/repositories/booking/booking_repository.dart';
import 'package:velotoulouse/model/user/user_subscription.dart';
import 'package:velotoulouse/ui/states/user_state.dart';

class StationDetailViewModel extends ChangeNotifier {
  final BookingRepository _bookingRepository;
  final UserState _userState;
  final String stationId;

  String? _selectedDockId;
  final Set<String> _bookedDockIds = {};

  String? get selectedDockId => _selectedDockId;
  Set<String> get bookedDockIds => _bookedDockIds;

  /// Reads active subscription from global state – always up-to-date.
  UserSubscription? get activeSubscription => _userState.user?.subscription;
  bool get hasActiveSubscription =>
      _userState.user?.hasActiveSubscription ?? false;

  StationDetailViewModel({
    required BookingRepository bookingRepository,
    required UserState userState,
    required this.stationId,
    Set<String> initialBookedDockIds = const {},
  }) : _bookingRepository = bookingRepository,
       _userState = userState {
    _bookedDockIds.addAll(initialBookedDockIds);

    // Seed from global state (active booking already loaded by UserState).
    final booking = _userState.user?.bookings.isNotEmpty == true
        ? _userState.user!.bookings.first
        : null;
    if (booking != null && booking.stationId == stationId) {
      _bookedDockIds.add(booking.dockId);
    }

    // Re-notify whenever global user data changes (subscription / booking).
    _userState.addListener(_onUserStateChanged);
  }

  void _onUserStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _userState.removeListener(_onUserStateChanged);
    super.dispose();
  }

  /// Refreshes the subscription from the backend via global state, then
  /// clears local booking state if the subscription is no longer active.
  Future<void> reloadSubscription() async {
    await _userState.refreshSubscription();
    if (!hasActiveSubscription) {
      _bookedDockIds.clear();
      _selectedDockId = null;
    }
    notifyListeners();
  }

  void toggleDock(String dockId) {
    _selectedDockId = _selectedDockId == dockId ? null : dockId;
    notifyListeners();
  }

  Future<void> confirmBooking(String dockId) async {
    await _bookingRepository.startBooking(stationId: stationId, dockId: dockId);
    _bookedDockIds.add(dockId);
    _selectedDockId = null;
    await _userState.refreshBooking();
    notifyListeners();
  }

  Future<void> cancelBooking(String dockId) async {
    await _bookingRepository.cancelBooking();
    _bookedDockIds.remove(dockId);
    _userState.clearBooking();
    notifyListeners();
  }

  void clearSelection() {
    _selectedDockId = null;
    notifyListeners();
  }
}
