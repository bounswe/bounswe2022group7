import 'package:android/network/discussion/post_discussion_vote_input.dart';
import 'package:android/network/discussion/post_discussion_vote_service.dart';
import 'package:android/pages/profile_page.dart';
import 'package:android/providers/user_provider.dart';
import 'package:flutter/material.dart';

import "package:android/models/models.dart";
import 'package:android/network/image/get_image_builder.dart';
import 'package:provider/provider.dart';

Discussion? currentDiscussion;

class DiscussionPage extends StatefulWidget {
  final Discussion? discussion;

  DiscussionPage({Key? key, required this.discussion}) : super(key: key) {
    currentDiscussion = discussion;
  }

  @override
  State<DiscussionPage> createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  Scaffold erroneousDiscussionPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discussion"),
      ),
      body: const Center(
        child: Text("Discussion not found"),
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

  @override
  Widget build(BuildContext context) {
    CurrentUser? user = Provider.of<UserProvider>(context).user;

    if (currentDiscussion == null) {
      return erroneousDiscussionPage();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discussion"),
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
                                currentDiscussion!.title,
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
                                      final output =
                                          await postDiscussionVoteNetwork(
                                              PostDiscussionVoteInput(
                                                  id: currentDiscussion!.id,
                                                  vote: -1));
                                      setState(() {
                                        if (output.discussion != null) {
                                          currentDiscussion =
                                              output.discussion!;
                                          currentDiscussion!
                                              .updateVote(user.username);
                                        } else {
                                          currentDiscussion!.voteStatus = -1;
                                        }
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.arrow_downward,
                                      color: currentDiscussion!.voteStatus == -1
                                          ? Colors.deepOrange
                                          : Colors.grey,
                                      size: 30.0)),
                              IconButton(
                                  onPressed: () async {
                                    if (user != null) {
                                      final output =
                                          await postDiscussionVoteNetwork(
                                              PostDiscussionVoteInput(
                                                  id: currentDiscussion!.id,
                                                  vote: 1));
                                      setState(() {
                                        if (output.discussion != null) {
                                          currentDiscussion =
                                              output.discussion!;
                                          currentDiscussion!
                                              .updateVote(user.username);
                                        } else {
                                          currentDiscussion!.voteStatus = 1;
                                        }
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.arrow_upward,
                                      color: currentDiscussion!.voteStatus == 1
                                          ? Colors.green
                                          : Colors.grey,
                                      size: 30.0)),
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
                                      navigateToHostProfile(currentDiscussion!
                                          .creatorAccountInfo.username);
                                    },
                                    child: Column(children: const [
                                      Text('Creator'),
                                      SizedBox(height: 3.0),
                                      Icon(
                                        Icons.supervisor_account,
                                        size: 25.0,
                                      ),
                                    ])),
                                Column(children: const [
                                  Text('Creation Date'),
                                  SizedBox(height: 3.0),
                                  Icon(
                                    Icons.calendar_today,
                                    size: 25.0,
                                  ),
                                ]),
                                Column(children: const [
                                  Text('Last Edit'),
                                  SizedBox(height: 3.0),
                                  Icon(
                                    Icons.calendar_month,
                                    size: 25.0,
                                  ),
                                ]),
                              ]),
                              TableRow(children: [
                                GestureDetector(
                                    onTap: () {
                                      navigateToHostProfile(currentDiscussion!
                                          .creatorAccountInfo.username);
                                    },
                                    child: Column(children: [
                                      Text(currentDiscussion!
                                                  .creatorAccountInfo.name ==
                                              null
                                          ? currentDiscussion!
                                              .creatorAccountInfo.username
                                          : currentDiscussion!
                                              .creatorAccountInfo.name!),
                                      circleAvatarBuilder(
                                          currentDiscussion!.creatorAccountInfo
                                              .profile_picture_id,
                                          20.0),
                                      const SizedBox(height: 3.0),
                                    ])),
                                Column(children: [
                                  Text(
                                    currentDiscussion!.creationDate
                                        .toString()
                                        .substring(0, 16),
                                  ),
                                ]),
                                Column(children: [
                                  Text(
                                    currentDiscussion!.lastEditDate
                                        .toString()
                                        .substring(0, 16),
                                  ),
                                ]),
                              ]),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            currentDiscussion!.textBody,
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
                              Text(currentDiscussion!.creationDate
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
  }
}
