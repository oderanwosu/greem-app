import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greem/providers/auth_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
                surfaceTintColor: Theme.of(context).colorScheme.error,
                // The width will be 100% of the parent widget
                // The height will be 60
                minimumSize: const Size.fromHeight(50)),
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).logout();
            },
            child: !ref.read(authControllerProvider).isLoading
                ? Text(
                    'Sign out',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )),
      ],
    );
  }
}
