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
        title: Text(widget.event.type),
        backgroundColor: Colors.blue[300],
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
                          Row(
                            children: [
                              Text(
                                widget.event.name,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon:
                                      const Icon(Icons.bookmark_add_outlined,
                                      color: Colors.black,
                                      size: 30.0,
                                      )),
                              IconButton(
                                  onPressed: () {},
                                  icon:
                                  const Icon(Icons.check_circle_outline,
                                    color: Colors.black,
                                    size: 30.0,

                                  )),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Table(
                            border: TableBorder.symmetric(
                                inside: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1.0,
                                ),
                                outside: BorderSide(color: Colors.grey[500]!)),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(children: [
                                Column(children: const [
                                  Text('Host'),
                                  SizedBox(height: 3.0),
                                  Icon(
                                    Icons.supervisor_account,
                                    size: 25.0,
                                  ),
                                ]),
                                Column(children: const [
                                  Text('Date'),
                                  SizedBox(height: 3.0),
                                  Icon(
                                    Icons.calendar_today,
                                    size: 25.0,
                                  ),
                                ]),
                                Column(children: const [
                                  Text('Location'),
                                  SizedBox(height: 3.0),
                                  Icon(
                                    Icons.location_on,
                                    size: 25.0,
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
                                  Text(
                                    widget.event.date
                                        .toString()
                                        .substring(0, 16),
                                  ),
                                ]),
                                Column(children: [
                                  Text(widget.event.location),
                                ]),
                              ]),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: const [
                              Text(
                                'Collaborators:',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
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
                          const SizedBox(height: 5.0),
                          const Divider(color: Colors.black),
                          const SizedBox(height: 5.0),
                          Row(
                            children:  [
                              const Icon(Icons.chat, size: 13.0),
                              const SizedBox(width: 5.0),
                              const Text(
                                // TODO: Add number of comments
                                "Comments (0)",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Text(widget.event.creationDate.toString().substring(0, 16)),
                            ],
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
