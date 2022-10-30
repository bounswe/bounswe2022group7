import 'package:android/providers/event_provider.dart';
import 'package:flutter/material.dart';

import "package:android/models/models.dart";
import 'package:android/network/event/get_event_service.dart';
import 'package:android/network/event/get_event_output.dart';

class EventPage extends StatefulWidget {
  final Event event;

  const EventPage({Key? key, required this.event}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Scaffold erroneousEventPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event"),
      ),
      body: const Center(
        child: Text("Event not found"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getEventNetwork(widget.event.id),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Snapshot Error!"),
                ),
                body: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              );
            }

            if (snapshot.data != null) {
              GetEventOutput responseData = snapshot.data!;
              if (responseData.status != "Success") {
                return erroneousEventPage();
              }
              Event currentEvent = Event(
                id: widget.event.id,
                name: responseData.name!,
                description: responseData.description!,
                location: responseData.location!,
                date: responseData.date!,
                type: responseData.type!,
                imageUrl: responseData.imageUrl!,
                host: responseData.host!,
                creationDate: responseData.creationDate!,
              );

              return erroneousEventPage();
            } else {
              // snapshot.data == null
              return erroneousEventPage();
            }
        }
      },
    );
  }
}
