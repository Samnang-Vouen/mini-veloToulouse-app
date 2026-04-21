import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velotoulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velotoulouse/data/repositories/user/user_repository.dart';
import 'package:velotoulouse/ui/screens/subscription/view%20modal/subscription_view_modal.dart';
import 'package:velotoulouse/ui/screens/subscription/widget/subscription_content.dart';
import 'package:velotoulouse/ui/states/user_state.dart';

class SubcriptionScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const SubcriptionScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SubscriptionViewModel(
        subscriptionRepository: context.read<SubscriptionRepository>(),
        userRepository: context.read<UserRepository>(),
        userState: context.read<UserState>(),
      ),
      child: SubscriptionContent(onBack: onBack),
    );
  }
}
