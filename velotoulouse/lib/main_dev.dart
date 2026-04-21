import 'package:provider/provider.dart';
import 'package:velotoulouse/data/repositories/station/station_repository.dart';
import 'package:velotoulouse/data/repositories/station/station_repository_real.dart';
import 'package:velotoulouse/main_common.dart';

List<InheritedProvider> get devProviders {

  return [
    Provider<StationRepository>(create: (_) => StationRepositoryReal()),
  ];
}

void main() {
  mainCommon();
}