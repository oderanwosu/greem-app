import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_providers.dart';
import '../../widgets/forms/register.dart';
import '../../widgets/snackbar.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  RegisterScreen({required this.toggleView});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        primary: true,
        child: Consumer(builder: ((context, ref, child) {
          final AsyncValue<void> state = ref.watch(authControllerProvider);
          return SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: !state.isLoading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RegisterForm(),
                            GestureDetector(
                              onTap: (() {
                                widget.toggleView();
                              }),
                              child: RichText(
                                  text: TextSpan(
                                      text: "Already Have an account? ",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).disabledColor),
                                      children: [
                                    TextSpan(
                                        text: 'Login',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold))
                                  ])),
                            ),
                          ],
                        )
                      : const Center(child: CircularProgressIndicator())));
        })),
      ),
    );
  }
}
