import 'package:android/pages/pages.dart';
import 'package:android/providers/event_provider.dart';
import 'package:android/providers/register_provider.dart';
import 'package:android/providers/user_provider.dart';
import 'package:android/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/config/app_routes.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: MaterialApp(
        title: 'ArtShare',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.data != null) {
                  Provider.of<UserProvider>(context).setUser(snapshot.data!);
                }
                return const HomePage();
            }
          },
        ),
        routes: {
          login: (context) => const Login(),
          register: (context) => const Register(),
          homepage: (context) => const HomePage(),
        },
        navigatorKey: navigatorKey,
      ),
    );
  }
}
