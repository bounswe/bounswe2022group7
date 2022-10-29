import 'package:flutter/material.dart';

import "package:android/models/models.dart";



class EventPage extends StatefulWidget {

  final Event event;
  const EventPage({Key? key, required this.event}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Event',
            ),
          ],
        ),
      ),
    );
  }
}
