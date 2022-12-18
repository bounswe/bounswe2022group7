import 'dart:convert';
import 'package:android/models/models.dart';
import 'package:android/network/event/get_event_output.dart';
import 'package:android/network/event/get_event_service.dart';
import 'package:android/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nock/nock.dart';

import 'package:android/pages/event_page.dart';
import 'package:android/config/api_endpoints.dart';
import 'package:provider/provider.dart';

import '../data/mock_data.dart';

Widget makeTestableWidget() => MaterialApp(home: Image.network(''));

void main() {
  dotenv.testLoad(fileInput: '''SERVER_PORT=8080
SERVER_IP=http://10.0.2.2
''');

  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('Should test Event Page with GET event http call',
      (WidgetTester tester) async {
    // mock data that is expected to be returned from the back-end
    int eventId = 1;
    Map<String, dynamic> eventResponse = {
      "id": 1,
      "type": "physical",
      "creatorId": 3,
      "creatorAccountInfo": {
        "email": "ahmet@example.com",
        "username": "artahm",
        "id": 4,
        "name": "Ahmet",
        "surname": "Can",
        "country": null,
        "dateOfBirth": null,
        "profilePictureId": null
      },
      "creationDate": "2022-12-02T09:14:28.000+00:00",
      "commentList": [],
      "eventInfo": {
        "id": 8,
        "title": "Van Gogh Museum Tour",
        "startingDate": "2022-12-03T09:14:28.000+00:00",
        "endingDate": "2022-12-05T09:14:28.000+00:00",
        "description":
            "Let us travel to Amsterdam together and visit the Van Gogh Museum!",
        "category": ["post-impressionism", "french"],
        "eventPrice": 20.0,
        "labels": ["relaxing", "painting"],
        "posterId": 7
      },
      "participantUsernames": [],
      "location": {
        "id": 9,
        "latitude": 52.3,
        "longitude": 4.8,
        "address": "Amsterdam Van Gogh Museum"
      },
      "rules": "Just try to be nice."
    };

    // mock GET event http call
    nock(eventURL).get('/$eventId/').reply(
          200,
          json.encode(eventResponse),
        );

    // mock GET posterId http call
    nock(getImageURL).get('/${eventResponse["eventInfo"]["posterId"]}/').reply(
          200,
          json.encode({
            "id": 7,
            "base64String": mockBase64Image,
          }),
        );

    await tester.pumpWidget(TestApp(FutureBuilder(
      future: getEventNetwork(eventId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return EventPage(event: null);
            }

            if (snapshot.data != null) {
              GetEventOutput responseData = snapshot.data!;
              if (responseData.status != "OK") {
                return EventPage(event: null);
              }
              Event currentEvent = responseData.event!;

              return EventPage(event: currentEvent);
            } else {
              // snapshot.data == null
              return EventPage(event: null);
            }
        }
      },
    )));
    await tester.pumpAndSettle();

    // test event title, description & address
    expect(find.text('Van Gogh Museum Tour'), findsOneWidget);
    expect(
        find.text(
            'Let us travel to Amsterdam together and visit the Van Gogh Museum!'),
        findsOneWidget);
    expect(find.text('Amsterdam Van Gogh Museum'), findsOneWidget);

    // test event host
    expect(find.text('Host'), findsOneWidget);
    expect(find.text('Ahmet'), findsOneWidget);

    // test the event poster
    expect(find.byType(Image), findsOneWidget);
  });
}

class TestApp extends StatelessWidget {
  final Widget child;

  const TestApp(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }
}
