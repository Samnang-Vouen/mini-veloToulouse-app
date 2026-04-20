import 'package:velotoulouse/model/booking/booking.dart';
import 'package:velotoulouse/model/user/user_subscription.dart';

class User {
  final String id;
  final String name;
  final String email;
  final UserSubscription? subscription;
  final List<Booking> bookings;

  const User({
    required this.id,
    this.name = '',
    required this.email,
    this.subscription,
    this.bookings = const [],
  });

  bool get hasActiveSubscription =>
      subscription != null && subscription!.isActive;

  User copyWith({
    String? id,
    String? name,
    String? email,
    UserSubscription? subscription,
    List<Booking>? bookings,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      subscription: subscription ?? this.subscription,
      bookings: bookings ?? this.bookings,
    );
  }
}
