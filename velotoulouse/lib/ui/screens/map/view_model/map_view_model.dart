import 'package:flutter/material.dart';
import 'package:velotoulouse/data/repositories/station/station_repository.dart';
import 'package:velotoulouse/model/station/station.dart';
import 'package:velotoulouse/ui/states/user_state.dart';
import 'package:velotoulouse/ui/utils/async_value.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepository stationRepository;
  final UserState userState;

  AsyncValue<List<Station>> stationsValue = AsyncValue.loading();

  final Map<String, Set<String>> _bookedDocksPerStation = {};

  List<Station> get stations => stationsValue.data ?? const [];

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  MapViewModel({required this.stationRepository, required this.userState}) {
    _init();
  }

  void _init() {
    final booking = userState.user?.bookings.isNotEmpty == true
        ? userState.user!.bookings.first
        : null;
    if (booking != null) {
      _bookedDocksPerStation[booking.stationId] = {booking.dockId};
    }
    userState.addListener(_onUserStateChanged);
    loadStations();
  }

  void _onUserStateChanged() {
    final booking = userState.user?.bookings.isNotEmpty == true
        ? userState.user!.bookings.first
        : null;
    if (booking == null) return;
    final existing = _bookedDocksPerStation[booking.stationId];
    if (existing == null || !existing.contains(booking.dockId)) {
      _bookedDocksPerStation[booking.stationId] = {booking.dockId};
      notifyListeners();
    }
  }

  @override
  void dispose() {
    userState.removeListener(_onUserStateChanged);
    super.dispose();
  }

  List<Station> get filteredStations {
    final all = stations;
    if (_searchQuery.isEmpty) return all;
    final q = _searchQuery.toLowerCase();
    return all.where((s) => s.name.toLowerCase().contains(q)).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Set<String> getBookedDocks(String stationId) =>
      _bookedDocksPerStation[stationId] ?? {};

  int effectiveAvailableBikes(Station station) {
    final booked = _bookedDocksPerStation[station.id]?.length ?? 0;
    final effective = station.availableBikes - booked;
    return effective < 0 ? 0 : effective;
  }

  void recordBookings(String stationId, Set<String> bookedDockIds) {
    if (bookedDockIds.isEmpty &&
        (_bookedDocksPerStation[stationId]?.isEmpty ?? true)) {
      return;
    }
    _bookedDocksPerStation[stationId] = Set.of(bookedDockIds);
    notifyListeners();
  }

  Future<void> onStationDetailClosed(
    String stationId,
    Set<String> bookedDockIds,
  ) async {
    recordBookings(stationId, bookedDockIds);
    await loadStations();
  }

  Future<void> loadStations() async {
    stationsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final all = await stationRepository.getStations();
      stationsValue = AsyncValue.success(
        all.where((s) => s.availableBikes > 0).toList(),
      );
    } catch (e) {
      stationsValue = AsyncValue.error(e);
    }

    notifyListeners();
  }
}
