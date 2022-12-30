import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greem/screens/messages_screens.dart/conversations.dart';

import '../../providers/auth_providers.dart';

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final AsyncValue<void> state = ref.read(authControllerProvider);

      return Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(
                height: 60,
              ),
              TextFormField(
                onChanged: (val) {
                  ref.read(authControllerProvider.notifier).email = val;
                },
                validator: (value) {
                  if (value == '') {
                    return 'Email cannot be left blank';
                  }
                },
                initialValue:
                    ref.read(authControllerProvider.notifier).email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                onChanged: (val) {
                  ref.read(authControllerProvider.notifier).password =
                      val;
                },
                validator: (value) {
                  if (value == '') {
                    return 'password cannot be left empty';
                  }
                },
                initialValue:
                    ref.read(authControllerProvider.notifier).password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      // The width will be 100% of the parent widget
                      // The height will be 60
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () async {
                    if ((_formKey.currentState!.validate())) {
                      await ref
                          .read(authControllerProvider.notifier)
                          .login();
                    }
                  },
                  child: const Text('Login')),
              SizedBox(
                height: 10,
              ),
              state.hasError
                  ? Text(state.error.toString(),
                      style: TextStyle(color: Theme.of(context).errorColor))
                  : Container(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      );
    });
  }
}
