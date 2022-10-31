import 'package:flutter/material.dart';
import 'package:android/models/models.dart';
import 'package:android/pages/event_page.dart';

class FeedContainer extends StatelessWidget {
  final ArtItem artItem;
  final Event event;

  const FeedContainer({Key? key, required this.artItem, required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        color: Colors.blue[100],
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventPage(id: event.id),
                ),
              );
            },
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage:
                                        NetworkImage(event.creator.imageUrl),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.eventInfo.title,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4.0),
                                        Row(
                                          children: [
                                            Icon(Icons.supervisor_account,
                                                size: 12.0,
                                                color: Colors.grey[600]),
                                            const SizedBox(width: 5.0),
                                            Text("Host: ${event.creator.name}"),
                                          ],
                                        )
                                      ]),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.bookmark_add_outlined,
                                          color: Colors.black, size: 30.0)),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.grey[600],
                                    size: 12.0,
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(
                                    event.eventInfo.startingDate.toString().substring(0, 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: Colors.grey[600],
                                    size: 12.0,
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(event.location.address)
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    event.eventInfo.posterUrl != null
                        ? Image.network(event.eventInfo.posterUrl!)
                        : Container(),
                    const SizedBox(height: 10.0),
                    Text(
                      event.eventInfo.description,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
            ])));
  }
}
