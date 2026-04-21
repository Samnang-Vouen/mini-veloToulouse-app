import 'package:provider/provider.dart';
import 'package:velotoulouse/data/repositories/booking/booking_repository.dart';
import 'package:velotoulouse/data/repositories/booking/booking_repository_real.dart';
import 'package:velotoulouse/data/repositories/station/station_repository.dart';
import 'package:velotoulouse/data/repositories/station/station_repository_real.dart';
import 'package:velotoulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velotoulouse/data/repositories/subscription/subscription_repository_real.dart';
import 'package:velotoulouse/data/repositories/user/user_repository.dart';
import 'package:velotoulouse/data/repositories/user/user_repository_real.dart';
import 'package:velotoulouse/main_common.dart';
import 'package:velotoulouse/ui/states/user_state.dart';

List<InheritedProvider> get devProviders {
  return [
    Provider<StationRepository>(create: (_) => StationRepositoryReal()),
    Provider<SubscriptionRepository>(
      create: (_) => SubscriptionRepositoryReal(),
    ),
    Provider<BookingRepository>(create: (_) => BookingRepositoryReal()),
    Provider<UserRepository>(create: (_) => UserRepositoryReal()),
    ChangeNotifierProvider<UserState>(
      create: (context) => UserState(
        userRepository: context.read<UserRepository>(),
        bookingRepository: context.read<BookingRepository>(),
      ),
    ),
  ];
}

void main() {
  mainCommon(devProviders);
}
