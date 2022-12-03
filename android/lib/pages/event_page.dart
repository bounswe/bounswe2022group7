import 'package:flutter/material.dart';

import "package:android/models/models.dart";
import 'package:android/network/event/get_event_service.dart';
import 'package:android/network/event/get_event_output.dart';
import 'package:android/network/image/get_image_builder.dart';

class EventPage extends StatefulWidget {
  final int id;

  const EventPage({Key? key, required this.id}) : super(key: key);

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
      future: getEventNetwork(widget.id),
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
              if (responseData.status != "OK") {
                return erroneousEventPage();
              }
              Event currentEvent = responseData.event!;

              Widget profileImg = imageBuilder(
                  currentEvent.creatorAccountInfo.profile_picture_id);
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Event"),
                  backgroundColor: Colors.blue[300],
                ),
                body: Container(
                  color: Colors.blue[50],
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Text(
                                          currentEvent.eventInfo.name,
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.bookmark_add_outlined,
                                              color: Colors.black,
                                              size: 30.0,
                                            )),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.check_circle_outline,
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
                                          outside: BorderSide(
                                              color: Colors.grey[500]!)),
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
                                            Text(currentEvent.creatorAccountInfo
                                                        .name ==
                                                    null
                                                ? ""
                                                : currentEvent
                                                    .creatorAccountInfo.name!),
                                            profileImg.toString() != "Container"
                                                ? CircleAvatar(
                                                    radius: 20.0,
                                                    backgroundColor:
                                                        Colors.grey[300],
                                                    backgroundImage:
                                                        (profileImg as Image)
                                                            .image,
                                                  )
                                                : Container(),
                                            const SizedBox(height: 3.0),
                                          ]),
                                          Column(children: [
                                            Text(
                                              currentEvent
                                                  .eventInfo.startingDate
                                                  .toString()
                                                  .substring(0, 16),
                                            ),
                                          ]),
                                          Column(children: [
                                            Text(currentEvent.location != null
                                                ? currentEvent.location!.address
                                                : ""),
                                          ]),
                                        ]),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        const Text(
                                          'Collaborators: ',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        Text(
                                          currentEvent.collaborators == null
                                              ? ""
                                              : currentEvent.collaborators!
                                                  .map((e) => e.name)
                                                  .join(", "),
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15.0),
                                    imageBuilder(
                                        currentEvent.eventInfo.imageId),
                                    const SizedBox(height: 15.0),
                                    Text(
                                      currentEvent.eventInfo.description,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    const Divider(color: Colors.black),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      children: [
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
                                        Text(currentEvent.creationDate
                                            .toString()
                                            .substring(0, 16)),
                                      ],
                                    ),
                                  ])),
                        ],
                      ),
                    ],
                  )),
                ),
              );
            } else {
              // snapshot.data == null
              return erroneousEventPage();
            }
        }
      },
    );
  }
}
