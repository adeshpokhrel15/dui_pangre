import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_wheelers/templates/widgets/buttom_navigation_bar.dart';

import '../../../providers/auth_provider.dart';
import 'onboarding_screen.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final auth = ref.watch(authProvider);
      return auth.when(
          data: (data) {
            if (data == null) {
              return const OnBoardingSreen();
            } else {
              return const BottomNavigationBarWidgets();
            }
          },
          error: (err, stack) => Text('$err'),
          loading: () => const CircularProgressIndicator());
    }));
  }
}
