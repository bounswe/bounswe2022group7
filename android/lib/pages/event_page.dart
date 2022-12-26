import 'package:android/network/event/post_event_participate_bookmark_service.dart';
import 'package:android/providers/user_provider.dart';
import 'package:android/widgets/annotatable_text.dart';
import 'package:android/pages/profile_page.dart';
import 'package:android/widgets/comment.dart';
import 'package:flutter/material.dart';

import "package:android/models/models.dart";
import 'package:android/network/image/get_image_builder.dart';
import 'package:provider/provider.dart';

import '../widgets/annotatable_image.dart';
import '../widgets/annotation_bar.dart';

Event? currentEvent;

class EventPage extends StatefulWidget {
  final Event? event;

  EventPage({Key? key, required this.event}) : super(key: key) {
    currentEvent = event;
  }

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  String comment = "";
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

  void navigateToHostProfile(_username) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(username: _username),
      ),
    );
  }

  void leaveComment() {
    print("comment: $comment");
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser? user = Provider.of<UserProvider>(context).user;
    if (currentEvent == null) {
      return erroneousEventPage();
    }
    if (user != null) {
      for (var comment in currentEvent!.commentList) {
        comment.updateStatus(user.username);
      }
    }
    final ValueNotifier<int> annotationModeNotifier = ValueNotifier(0);
    final ValueNotifier<Map<String, dynamic>?> annotationNotifier =
    ValueNotifier(null);

    final ValueNotifier<List<Map<String, dynamic>>> annotationListNotifier =
    ValueNotifier([]);
    final ValueNotifier<int> annotationCountNotifier = ValueNotifier(0);

    Widget imageBuilderResult =
    imageBuilder(currentEvent!.eventInfo.imageId);

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
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                currentEvent!.eventInfo.name,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    if (user != null) {
                                      final output = await postEventMarkNetwork(
                                          currentEvent!.id, "bookmark");
                                      setState(() {
                                        if (output.event != null) {
                                          currentEvent = output.event!;
                                          currentEvent!
                                              .updateStatus(user.username);
                                        } else {
                                          if (currentEvent!.bookmarkStatus ==
                                              0) {
                                            currentEvent!.bookmarkStatus = 1;
                                          } else {
                                            currentEvent!.bookmarkStatus = 0;
                                          }
                                        }
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.bookmark_add_outlined,
                                    color: currentEvent!.bookmarkStatus == 0
                                        ? Colors.black
                                        : Colors.orange,
                                    size: 30.0,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    if (user != null) {
                                      final output = await postEventMarkNetwork(
                                          currentEvent!.id, "participate");
                                      setState(() {
                                        if (output.event != null) {
                                          currentEvent = output.event!;
                                          currentEvent!
                                              .updateStatus(user.username);
                                        } else {
                                          if (currentEvent!
                                                  .participationStatus ==
                                              0) {
                                            currentEvent!.participationStatus =
                                                1;
                                          } else {
                                            currentEvent!.participationStatus =
                                                0;
                                          }
                                        }
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.check_circle_outline,
                                    color:
                                        currentEvent!.participationStatus == 0
                                            ? Colors.black
                                            : Colors.green,
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
                                GestureDetector(
                                    onTap: () {
                                      navigateToHostProfile(currentEvent!
                                          .creatorAccountInfo.username);
                                    },
                                    child: Column(children: const [
                                      Text('Host'),
                                      SizedBox(height: 3.0),
                                      Icon(
                                        Icons.supervisor_account,
                                        size: 25.0,
                                      ),
                                    ])),
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
                                GestureDetector(
                                    onTap: () {
                                      navigateToHostProfile(currentEvent!
                                          .creatorAccountInfo.username);
                                    },
                                    child: Column(children: [
                                      Text(currentEvent!
                                                  .creatorAccountInfo.name ==
                                              null
                                          ? currentEvent!
                                              .creatorAccountInfo.username
                                          : currentEvent!
                                              .creatorAccountInfo.name!),
                                      circleAvatarBuilder(
                                          currentEvent!.creatorAccountInfo
                                              .profile_picture_id,
                                          20.0),
                                      const SizedBox(height: 3.0),
                                    ])),
                                Column(children: [
                                  Text(
                                    currentEvent!.eventInfo.startingDate
                                        .toString()
                                        .substring(0, 16),
                                  ),
                                ]),
                                Column(children: [
                                  Text(currentEvent!.location != null
                                      ? currentEvent!.location!.address
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
                                currentEvent!.collaborators == null
                                    ? ""
                                    : currentEvent!.collaborators!
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
                          buildAnnotatableImage(
                            imageBuilderResult,
                            annotationModeNotifier,
                            annotationNotifier,
                            annotationListNotifier,
                          ),
                          const SizedBox(height: 10.0),
                          currentEvent!.eventInfo.imageId != null
                            ? AnnotationBar(
                                editable: user != null,
                                imageId: currentEvent!.eventInfo.imageId!,
                                countNotifier: annotationCountNotifier,
                                modeNotifier: annotationModeNotifier,
                                annotationNotifier: annotationNotifier,
                                annotationListNotifier: annotationListNotifier)
                            : const SizedBox.shrink(),
                          const SizedBox(height: 15.0),
                          AnnotatableText(
                            currentEvent!.eventInfo.description,
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
                              Text(
                                // TODO: Add number of comments
                                "Comments ${currentEvent!.commentList.length}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Text(currentEvent!.creationDate
                                  .toString()
                                  .substring(0, 16)),
                            ],
                          ),
                          // const Padding(padding: EdgeInsets.all(8.0)),
                          CommentListWidget(
                            commentList: currentEvent!.commentList,
                          ),
                          const Padding(padding: EdgeInsets.all(4.0)),
                          CommentWidget(
                              postid: currentEvent!.id, post_type: "event"),
                        ])),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
