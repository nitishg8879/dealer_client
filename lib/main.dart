import 'package:bike_client_dealer/config/default_firebase_options.dart';
import 'package:bike_client_dealer/config/routes/app_routes.dart';
import 'package:bike_client_dealer/config/themes/app_theme.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
      theme: AppTheme.lightTheme,
    );
  }
}
