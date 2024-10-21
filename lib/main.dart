import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pollusafe_app/src/routes/app_navigation.dart';
import 'package:pollusafe_app/src/widgets/notification/local_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await LocalNotification.init();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // routeInformationParser: _router.routeInformationParser,
      // routerDelegate: _router.routerDelegate,
      // routeInformationProvider: _router.routeInformationProvider,
      routerConfig: AppNavigation.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
