import 'package:velotoulouse/data/dummy_data.dart';
import 'package:velotoulouse/data/repositories/station/station_repository_real.dart';
import 'package:velotoulouse/model/station/station.dart';

class StationRepositoryMock implements StationRepository {
  @override
  Future<List<Station>> getStations() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return DummyData.stations;
  }
}