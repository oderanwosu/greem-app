import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greem/widgets/snackbar.dart';

import '../../providers/auth_providers.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm();

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final AsyncValue<void> state = ref.watch(authControllerProvider);
      return Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Text(
                'Register',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                initialValue:
                    ref.read(authControllerProvider.notifier).username,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter username'),
                onChanged: (val) {
                  ref.read(authControllerProvider.notifier).username = val;
                },
                validator: (value) {
                  if (value == '') {
                    return 'Username cannot be left empty';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: ref.read(authControllerProvider.notifier).email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter email'),
                onChanged: (val) {
                  ref.read(authControllerProvider.notifier).email = val;
                },
                validator: (value) {
                  if (value == '') {
                    return 'email cannot be left empty';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: ref.read(authControllerProvider.notifier).fname,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter first name'),
                onChanged: (val) {
                  ref.read(authControllerProvider.notifier).fname = val;
                },
                validator: (value) {
                  if (value == '') {
                    return 'first name cannot be left empty';
                  }
                },
              ),
              TextFormField(
                initialValue: ref.read(authControllerProvider.notifier).lname,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter last name'),
                onChanged: (val) {
                  ref.read(authControllerProvider.notifier).lname = val;
                },
                validator: (value) {
                  if (value == '') {
                    return 'email cannot be left empty';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue:
                    ref.read(authControllerProvider.notifier).password,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter password',
                ),
                onChanged: (val) {
                  ref.read(authControllerProvider.notifier).password = val;
                },
                validator: (value) {
                  if (value == '') {
                    return 'password cannot be left empty';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue:
                    ref.read(authControllerProvider.notifier).confirmPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Re-enter password',
                ),
                onChanged: (val) {
                  ref.read(authControllerProvider.notifier).confirmPassword =
                      val;
                },
                validator: (value) {
                  if (value == '') {
                    return 'confirm password';
                  }
                },
              ),
              const SizedBox(
                height: 20,
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
                          .register();
                    }
                    if (!state.hasError) {}
                  },
                  child: const Text('Register')),
              SizedBox(
                height: 10,
              ),
              state.hasError
                  ? Text(state.error.toString(),
                      style: TextStyle(color: Theme.of(context).errorColor))
                  : Container(),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      );
    });
  }
}
