import 'package:velotoulouse/model/station/station.dart';

abstract class StationRepository {
  Future<List<Station>> getStations();
}
