import 'package:android/models/models.dart';
import 'package:android/pages/settings_page.dart';
import 'package:android/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:nock/nock.dart';

import "package:android/config/api_endpoints.dart";
import '../data/mock_data.dart';

void main() {
  dotenv.testLoad(fileInput: '''SERVER_PORT=8080
SERVER_IP=http://10.0.2.2
''');

  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('Settings page widgets are correct and working',
      (WidgetTester tester) async {
    // mock GET settings, with authentication
    nock('$settingsURL/').get('').reply(200, {
      "email": "ahmet@example.com",
      "username": "ahmet123",
      "name": "Ahmet",
      "surname": "Can",
      "country": "Turkey",
      "dateOfBirth": "1999-12-12T00:00:00.000+00:00",
      "profilePictureId": 5
    });

    // mock GET profile picture
    nock(getImageURL).get('/${5}/').reply(200, {
      "id": 5,
      "base64String": mockBase64Image,
    });

    // prepare a UserProvider:
    final userProvider = UserProvider();
    userProvider.setUser(CurrentUser(
        token: "<TEST_TOKEN>",
        email: "ahmet@example.com",
        username: "ahmet123"));

    // prepare a MaterialApp:
    final testWidget = MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>.value(value: userProvider),
        ],
        child: const SettingsPage(),
      ),
    );

    // build the widget:
    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    // check the basic widgets
    expect(find.text("Settings"), findsOneWidget);
    expect(find.text("Personal Information"), findsOneWidget);
    expect(find.text("Account Management"), findsOneWidget);
    expect(find.text("Notifications"), findsOneWidget);
    expect(find.text("Blocking"), findsOneWidget);
    expect(find.text("Copyright Reports"), findsOneWidget);
    expect(find.text("Help"), findsOneWidget);

    // check the user data
    expect(find.text("ahmet123"), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}
