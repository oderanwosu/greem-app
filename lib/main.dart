import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greem/providers/auth_providers.dart';
import 'package:greem/screens/auth_screens/auth.dart';
import 'package:greem/screens/messages_screens.dart/conversations.dart';
import 'package:greem/screens/auth_screens/register.dart';

import 'providers/routes_provider.dart';
import 'screens/auth_screens/login.dart';
import 'widgets/forms/login.dart';
import 'widgets/forms/register.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

// class MyApp extends ConsumerStatefulWidget {
//   MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends ConsumerState<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     final router = ref.watch(routerProvider);
//     final authState = ref.watch(authStateProvider);
//     Widget _buildApp() {
//       return MaterialApp.router(
//         routerConfig: router.router,
//         // routerConfig: RoutesToGoRouterAdapter(router.router, "/", redirect: router.routeRedirectPolicy).goRouter,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//       );
//     }

//     Widget _LandingScreen() {
//       return MaterialApp(
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: Scaffold(
//           body: Column(
//             children: const [
//               Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Consumer(builder: ((context, ref, child) {
//       return authState.when(
//           data: ((data) {
//             return _buildApp();
//           }),
//           error: (error, stackTrace) => _LandingScreen(),
//           loading: () => _LandingScreen());
//     }));
//   }
// }

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final initState = ref.watch(appInitializationProvider);

    Widget _buildApp() {
      return MaterialApp.router(
          routerConfig: router.router,
          // routerConfig: RoutesToGoRouterAdapter(router.router, "/", redirect: router.routeRedirectPolicy).goRouter,
          title: 'Flutter Demo',
          theme: ThemeData.dark());
    }

    Widget _LandingScreen() {
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Column(
            children: const [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      );
    }

    return initState.when(
        data: ((data) {
          return _buildApp();
        }),
        error: (error, stackTrace) => _LandingScreen(),
        loading: () => _LandingScreen());
  }
}
