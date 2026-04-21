
import 'package:velotoulouse/model/docks/dock.dart';

class Station {
  final String id;
  final String name;
  final String streetName;
  final List<Dock> dock;
  final double latitude;
  final double longitude;

  Station({
    required this.id,
    required this.name,
    required this.dock,
    required this.streetName,
    required this.latitude,
    required this.longitude,
  });

  int get availableBikes => dock.where((d) => d.bike.isNotEmpty).length;
}
