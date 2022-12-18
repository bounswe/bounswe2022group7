import 'package:android/network/discussion/get_discussion_output.dart';
import 'package:android/network/discussion/get_discussion_service.dart';
import 'package:android/network/discussion/post_discussion_vote_input.dart';
import 'package:android/network/discussion/post_discussion_vote_service.dart';
import 'package:android/network/image/get_image_builder.dart';
import 'package:android/pages/discussion_page.dart';
import 'package:android/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:android/models/models.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

List<Discussion> discussions = [];

class DiscussionForumPage extends StatefulWidget {
  DiscussionForumPage({Key? key, required discussionList}) : super(key: key) {
    discussions = discussionList;
  }

  @override
  State<DiscussionForumPage> createState() => _DiscussionForumPage();
}

class _DiscussionForumPage extends State<DiscussionForumPage> {
  void logout() {
    setState(() {
      Provider.of<UserProvider>(context, listen: false).logout();
      Navigator.pop(context); // close pop up
      Navigator.pop(context); // close drawer
    });
  }

  Widget buildDiscussion(BuildContext context, CurrentUser? user, int index) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        color: Colors.blue[100],
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FutureBuilder(
                    future: getDiscussionNetwork(discussions[index].id),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                            return DiscussionPage(discussion: null);
                          }
                          if (snapshot.data != null) {
                            GetDiscussionOutput responseData = snapshot.data!;
                            if (responseData.status != "OK") {
                              return DiscussionPage(discussion: null);
                            }
                            Discussion? currentDiscussion =
                                responseData.discussion;
                            currentDiscussion?.updateVote(user!.username);
                            return DiscussionPage(
                                discussion: currentDiscussion);
                          } else {
                            return DiscussionPage(discussion: null);
                          }
                      }
                    },
                  ),
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
                                  circleAvatarBuilder(
                                      discussions[index]
                                          .creatorAccountInfo
                                          .profile_picture_id,
                                      20.0),
                                  const SizedBox(width: 10.0),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          discussions[index].title,
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
                                            Text(discussions[index]
                                                .creatorAccountInfo
                                                .username),
                                          ],
                                        )
                                      ]),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () async {
                                        if (user != null) {
                                          final output =
                                              await postDiscussionVoteNetwork(
                                                  PostDiscussionVoteInput(
                                                      id: discussions[index].id,
                                                      vote: -1));
                                          setState(() {
                                            if (output.discussion != null) {
                                              discussions[index] =
                                                  output.discussion!;
                                              discussions[index]
                                                  .updateVote(user.username);
                                            } else {
                                              discussions[index].voteStatus =
                                                  -1;
                                            }
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.arrow_downward,
                                          color:
                                              discussions[index].voteStatus ==
                                                      -1
                                                  ? Colors.deepOrange
                                                  : Colors.grey,
                                          size: 30.0)),
                                  IconButton(
                                      onPressed: () async {
                                        if (user != null) {
                                          final output =
                                              await postDiscussionVoteNetwork(
                                                  PostDiscussionVoteInput(
                                                      id: discussions[index].id,
                                                      vote: 1));
                                          setState(() {
                                            if (output.discussion != null) {
                                              discussions[index] =
                                                  output.discussion!;
                                              discussions[index]
                                                  .updateVote(user.username);
                                            } else {
                                              discussions[index].voteStatus = 1;
                                            }
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.arrow_upward,
                                          color:
                                              discussions[index].voteStatus == 1
                                                  ? Colors.green
                                                  : Colors.grey,
                                          size: 30.0)),
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
                                    discussions[index]
                                        .creationDate
                                        .toString()
                                        .substring(0, 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      discussions[index].textBody,
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

  Scaffold discussionForumPageScaffold(CurrentUser? user) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        mainAppBar(context, user),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return buildDiscussion(context, user, index);
            },
            childCount: discussions.length,
          ),
        ),
      ]),
      drawer: mainDrawer(context, user, logout),
      bottomNavigationBar: mainBottomBar(context, user, 2),
    );
  }

  Scaffold erroneousDiscussionForumPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discussion Forum Page"),
      ),
      body: const Center(
        child: Text("Error"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser? user = Provider.of<UserProvider>(context).user;
    if (discussions.isEmpty) {
      return erroneousDiscussionForumPage();
    }
    return discussionForumPageScaffold(user);
  }
}
