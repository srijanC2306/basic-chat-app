import 'package:chat_app/first_view/first_view.dart';
import 'package:chat_app/scecond_screen.dart';
import 'package:chat_app/services/firebase_messaging_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


final GlobalKey<NavigatorState> globalNavKey  = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessagingService().initialize();
  FirebaseMessagingService().getToken();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance ;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
       final  FirebaseAnalytics analytics = FirebaseAnalytics.instance ;
       final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics)  ;
    return MaterialApp(
      navigatorObservers:  <NavigatorObserver>[observer],
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

