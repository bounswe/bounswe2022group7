import 'package:android/network/discussion/get_discussionlist_output.dart';
import 'package:android/network/discussion/get_discussionlist_service.dart';
import 'package:android/network/image/get_image_builder.dart';
import 'package:android/pages/discussion_page.dart';
import 'package:android/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:android/models/models.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

Widget buildDiscussion(BuildContext context, Discussion discussion) {
  return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.blue[100],
      child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiscussionPage(id: discussion.id),
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
                                    discussion
                                        .creatorAccountInfo.profile_picture_id,
                                    20.0),
                                const SizedBox(width: 10.0),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        discussion.title,
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
                                          Text(discussion
                                              .creatorAccountInfo.username),
                                        ],
                                      )
                                    ]),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.arrow_downward,
                                        color: Colors.deepOrange, size: 30.0)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.arrow_upward,
                                        color: Colors.green, size: 30.0)),
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
                                  discussion.creationDate
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
                    discussion.textBody,
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

class DiscussionForumPage extends StatefulWidget {
  const DiscussionForumPage({Key? key}) : super(key: key);

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

  Scaffold discussionForumPageScaffold(
      CurrentUser? user, List<Discussion> discussionList) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        mainAppBar(context, user),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return buildDiscussion(context, discussionList[index]);
            },
            childCount: discussionList.length,
          ),
        ),
      ]),
      drawer: mainDrawer(context, user, logout),
      bottomNavigationBar: mainBottomBar(context, 2),
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

    return FutureBuilder(
      future: getDiscussionPosts(),
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
              GetDiscussionListOutput responseData = snapshot.data!;
              if (responseData.status != "OK") {
                return erroneousDiscussionForumPage();
              }
              List<Discussion> discussionList = responseData.list!;
              return discussionForumPageScaffold(user, discussionList);
            } else {
              // snapshot.data == null
              return erroneousDiscussionForumPage();
            }
        }
      },
    );
  }
}
