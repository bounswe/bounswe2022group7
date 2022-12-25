import 'package:android/pages/create_art_item_page.dart';
import 'package:android/pages/pages.dart';
import 'package:android/providers/login_provider.dart';
import 'package:android/providers/register_provider.dart';
import 'package:android/providers/user_provider.dart';
import 'package:android/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import '/config/app_routes.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        title: 'ideart',
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
          createEventPage: (context) => const CreateEvent(),
          createArtItemPage: (context) => const CreateArtItemPage(),
          profilePage: (context) => ProfilePage(),
          settingsPage: (context) => const SettingsPage(),
          accountInfoPage: (context) => const AccountInfoPage(),
        },
        navigatorKey: navigatorKey,
      ),
    );
  }
}
