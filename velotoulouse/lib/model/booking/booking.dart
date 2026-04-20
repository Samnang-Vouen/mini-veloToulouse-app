class Booking {
  final String id;
  final String stationId;
  final String dockId;
  final DateTime startTime;

  const Booking({
    required this.id,
    required this.stationId,
    required this.dockId,
    required this.startTime,
  });
}
