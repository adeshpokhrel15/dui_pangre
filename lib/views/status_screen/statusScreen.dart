import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_wheelers/views/screens/home_screen.dart';

import '../../providers/auth_provider.dart';
import '../onboarding screen/intro_screen.dart';

class StatusCheck extends StatelessWidget {
  const StatusCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final auth = ref.watch(authProvider);
      return auth.when(
          data: (data) {
            if (data == null) {
              return const IntroScreen();
            } else {
              return const HomeScreen();
            }
          },
          error: (err, stack) => Text('$err'),
          loading: () => const CircularProgressIndicator());
    }));
  }
}
