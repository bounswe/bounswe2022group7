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
        title: const Text("Physical Exhibition"),
      ),
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10.0),
                          Text(
                            widget.event.name,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 15.0),
                          Table(
                            border: TableBorder.symmetric(
                                inside: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1.0,
                                ),
                                outside: BorderSide(color: Colors.grey[700]!)),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(children: [
                                Column(children: const [
                                  Text('Host'),
                                  SizedBox(height: 3.0),
                                  Icon(
                                    Icons.supervisor_account,
                                    size: 30.0,
                                  ),
                                ]),
                                Column(children: const [
                                  Text('Date'),
                                  SizedBox(height: 3.0),
                                  Icon(
                                    Icons.calendar_today,
                                    size: 30,
                                  ),
                                ]),
                                Column(children: const [
                                  Text('Location'),
                                  SizedBox(height: 3.0),
                                  Icon(
                                    Icons.location_on,
                                    size: 30,
                                  ),
                                ]),
                              ]),
                              TableRow(children: [
                                Column(children: [
                                  Text(widget.event.host.name),
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: NetworkImage(
                                        widget.event.host.imageUrl),
                                  ),
                                  const SizedBox(height: 3.0),
                                ]),
                                Column(children: [
                                  Text(widget.event.date.toString().substring(0, 16),),
                                ]),
                                Column(children: [
                                  Text(widget.event.location),
                                ]),
                              ]),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Image(image: NetworkImage(widget.event.imageUrl)),
                          const SizedBox(height: 15.0),
                          Text(
                            widget.event.description,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
