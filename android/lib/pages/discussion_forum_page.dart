import 'package:android/network/discussion/get_discussionlist_output.dart';
import 'package:android/network/discussion/get_discussionlist_service.dart';
import 'package:android/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:android/models/models.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

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
              return Container();
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
