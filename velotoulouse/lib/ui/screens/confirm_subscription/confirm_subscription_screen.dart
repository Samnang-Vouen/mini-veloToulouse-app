import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velotoulouse/data/repositories/user/user_repository.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';
import 'package:velotoulouse/ui/screens/confirm_subscription/view_model/confirm_subscription_view_model.dart';
import 'package:velotoulouse/ui/screens/confirm_subscription/widgets/confirm_subscription_content.dart';
import 'package:velotoulouse/ui/states/user_state.dart';

class ConfirmSubscriptionScreen extends StatelessWidget {
  final SubscriptionPlan plan;

  const ConfirmSubscriptionScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConfirmSubscriptionViewModel(
        userRepository: context.read<UserRepository>(),
        userState: context.read<UserState>(),
      ),
      child: ConfirmSubscriptionContent(plan: plan),
    );
  }
}
