import 'package:flutter/material.dart';
import 'package:velotoulouse/data/repositories/booking/booking_repository.dart';
import 'package:velotoulouse/model/station/station.dart';
import 'package:velotoulouse/model/user/user_subscription.dart';
import 'package:velotoulouse/ui/states/user_state.dart';

class StationDetailViewModel extends ChangeNotifier {
  final BookingRepository bookingRepository;
  final UserState userState;
  final Station station;
  String get stationId => station.id;

  String? _selectedDockId;
  final Set<String> _bookedDockIds = {};

  String? get selectedDockId => _selectedDockId;
  Set<String> get bookedDockIds => _bookedDockIds;

  UserSubscription? get activeSubscription => userState.user?.subscription;
  bool get hasActiveSubscription =>
      userState.user?.hasActiveSubscription ?? false;

  StationDetailViewModel({
    required this.bookingRepository,
    required this.userState,
    required this.station,
    Set<String> initialBookedDockIds = const {},
  }) {
    init(initialBookedDockIds);
  }

  void init(Set<String> initialBookedDockIds) {
    _bookedDockIds.addAll(initialBookedDockIds);

    final booking = userState.user?.bookings.isNotEmpty == true
        ? userState.user!.bookings.first
        : null;
    if (booking != null && booking.stationId == stationId) {
      _bookedDockIds.add(booking.dockId);
    }

    userState.addListener(_onUserStateChanged);
  }

  void _onUserStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    userState.removeListener(_onUserStateChanged);
    super.dispose();
  }

  void toggleDock(String dockId) {
    _selectedDockId = _selectedDockId == dockId ? null : dockId;
    notifyListeners();
  }

  void clearSelection() {
    _selectedDockId = null;
    notifyListeners();
  }

  Future<void> reloadSubscription() async {
    await userState.refreshSubscription();
    if (!hasActiveSubscription) {
      _bookedDockIds.clear();
      _selectedDockId = null;
    }
    notifyListeners();
  }

  Future<void> confirmBooking(String dockId) async {
    await bookingRepository.startBooking(stationId: stationId, dockId: dockId);
    _bookedDockIds.add(dockId);
    _selectedDockId = null;
    await userState.refreshBooking();
    notifyListeners();
  }

  Future<void> cancelBooking(String dockId) async {
    await bookingRepository.cancelBooking();
    _bookedDockIds.remove(dockId);
    userState.clearBooking();
    notifyListeners();
  }
}
