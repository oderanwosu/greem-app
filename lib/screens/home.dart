import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greem/providers/providers.dart';

import '../models/token.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final state = ref.watch(tokensProvider);
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        // The width will be 100% of the parent widget
                        // The height will be 60
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: () async {
                      await state.deleteLocalTokens();
                    },
                    child: const Text('Register')),
              )
            ]),
          ),
        ),
      );
    }));
  }
}
