import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velotoulouse/data/repositories/station/station_repository.dart';
import 'package:velotoulouse/ui/screens/map/view_model/map_view_model.dart';
import 'package:velotoulouse/ui/screens/map/widgets/map_content.dart';
import 'package:velotoulouse/ui/states/user_state.dart';
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapViewModel(
        stationRepository: context.read<StationRepository>(),
        userState: context.read<UserState>(),
      ),
      child: const MapContent(),
    );
  }
}