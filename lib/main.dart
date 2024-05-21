import 'package:chat_app/first_view/first_view.dart';
import 'package:chat_app/scecond_screen.dart';
import 'package:chat_app/services/push_notification_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> globalNavKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PushNotificationService _pushNotificationService =
      PushNotificationService();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _pushNotificationService.initialize(context);
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    final FirebaseAnalyticsObserver observer =
        FirebaseAnalyticsObserver(analytics: analytics);
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      title: 'Flutter Demo',
      navigatorKey: globalNavKey,
      onGenerateRoute: _onGenerateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirstView(),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SecondScreen.secondScreenRoute:
        return MaterialPageRoute(builder: (_) => SecondScreen());
      default:
        return MaterialPageRoute(builder: (_) => FirstView());
    }
  }
}
