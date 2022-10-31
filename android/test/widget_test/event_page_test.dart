import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nock/nock.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:android/pages/event_page.dart';
import 'package:android/config/api_endpoints.dart';

Widget makeTestableWidget() => MaterialApp(home: Image.network(''));

void main() {
  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('Should test Event Page with GET event http call',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(makeTestableWidget()));

    // mock data that is expected to be returned from the back-end
    int eventId = 1;
    Map<String, dynamic> eventResponse = {
      "id": 1,
      "creator": null,
      "collaborators": [],
      "participants": [],
      "creationDate": "2022-10-31T18:49:20.000+00:00",
      "commentList": [],
      "eventInfo": {
        "id": 27,
        "title": "Venice the Mourning City",
        "startingDate": "2022-10-31T18:49:20.000+00:00",
        "endingDate": "2022-10-31T18:49:20.000+00:00",
        "description": "Stories of seperations, tears of loves",
        "category": "[\"kubism\", \"oil painting\", \"wooden sculpture\"]",
        "eventPrice": 0.0,
        "labels": "[\"romantic\", \"engraving\", \"carving\"]",
        "posterUrl":
            "https://i.pinimg.com/originals/c7/9a/b6/c79ab6b3943e4e75fa0742a8ce9a76e6.jpg"
      },
      "location": {
        "id": 28,
        "lattitude": 0.0,
        "longitude": 0.0,
        "address": "Venice"
      },
      "rules": "",
      "attendees": [],
      "bookmarkedBy": []
    };

    // mock GET event http call
    nock(eventURL).get('/$eventId/').reply(
          200,
          json.encode(eventResponse),
        );

    await tester.pumpWidget(TestApp(EventPage(id: eventId)));
    await tester.pumpAndSettle();

    // test event title, description & address
    expect(find.text('Venice the Mourning City'), findsOneWidget);
    expect(find.text('Stories of seperations, tears of loves'), findsOneWidget);
    expect(find.text('Venice'), findsOneWidget);

    // test event host
    expect(find.text('Host'), findsOneWidget);
    expect(find.text('Ahmet'),
        findsOneWidget); // since the User is not implemented, we use dummy data
  });
}

class TestApp extends StatelessWidget {
  final Widget child;

  const TestApp(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: child,
    );
  }
}
