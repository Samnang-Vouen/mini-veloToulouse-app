import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velotoulouse/data/repositories/booking/booking_repository.dart';
import 'package:velotoulouse/model/station/station.dart';
import 'package:velotoulouse/ui/screens/map/view_model/map_view_model.dart';
import 'package:velotoulouse/ui/screens/station/view_model/station_detail_view_model.dart';
import 'package:velotoulouse/ui/screens/station/widgets/station_content.dart';
import 'package:velotoulouse/ui/states/user_state.dart';

class StationDetailScreen extends StatelessWidget {
  final Station station;

  const StationDetailScreen({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final alreadyBooked = context.read<MapViewModel>().getBookedDocks(
      station.id,
    );

    return ChangeNotifierProvider(
      create: (context) => StationDetailViewModel(
        bookingRepository: context.read<BookingRepository>(),
        userState: context.read<UserState>(),
        stationId: station.id,
        initialBookedDockIds: alreadyBooked,
      ),
      child: StationContent(station: station),
    );
  }
}
