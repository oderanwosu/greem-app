import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../widgets/forms/login.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({required this.toggleView});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: ((context, ref, child) {
          final AsyncValue<void> state =
              ref.watch(authScreenControllerProvider);
          return SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: !state.isLoading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoginForm(),
                            GestureDetector(
                              onTap: (() {
                                widget.toggleView();
                              }),
                              child: RichText(
                                  text: TextSpan(
                                      text: "Don't have an account? ",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).disabledColor),
                                      children: [
                                    TextSpan(
                                        text: 'Register',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold))
                                  ])),
                            )
                          ],
                        )
                      : const Center(child: CircularProgressIndicator())));
        }),
      ),
    );
  }
}
