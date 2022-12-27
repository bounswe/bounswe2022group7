import 'package:android/config/app_routes.dart';
import 'package:android/network/discussion/get_discussionlist_output.dart';
import 'package:android/network/discussion/get_discussionlist_service.dart';
import 'package:android/network/home/get_postlist_output.dart';
import 'package:android/pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:android/widgets/feed_container.dart';

import 'package:android/models/models.dart';
import 'package:provider/provider.dart';

import '../network/home/get_postlist_service.dart';
import '../providers/user_provider.dart';
import '../widgets/alert.dart';
import 'discussion_forum_page.dart';

SliverAppBar mainAppBar(BuildContext context, CurrentUser? user) {
  return SliverAppBar(
    backgroundColor: Colors.blue[300],
    title: const Text(
      'ideart.',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'monospace',
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.2,
      ),
    ),
    centerTitle: false,
    floating: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        iconSize: 30.0,
        color: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, searchPage);
        },
      ),
      user == null
          ? TextButton(
              onPressed: () {
                Navigator.pushNamed(context, login);
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0,
                ),
              ),
            )
          : IconButton(
              icon: const Icon(Icons.account_circle),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
    ],
  );
}

Drawer mainDrawer(BuildContext context, CurrentUser? user, Function() logout) {
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Vincent_Van_Gogh_-_Three_Sunflowers_F453.jpg/1280px-Vincent_Van_Gogh_-_Three_Sunflowers_F453.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: const [
              Text(
                "ideart.",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    letterSpacing: 0.2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
        if (user != null)
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Profile"),
            onTap: () {
              Navigator.pushNamed(context, profilePage);
            },
          ),
        if (user != null)
          ListTile(
            leading: Icon(Icons.art_track),
            title: Text("Create Art Item"),
            onTap: () {
              Navigator.pushNamed(context, createArtItemPage);
            },
          ),
        if (user != null)
          ListTile(
            leading: Icon(Icons.art_track),
            title: Text("Create Event"),
            onTap: () {
              Navigator.pushNamed(context, createEventPage);
            },
          ),
        ListTile(
          leading: Icon(Icons.forum),
          title: Text("Discussion Page"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FutureBuilder(
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
                                GetDiscussionListOutput responseData =
                                    snapshot.data!;
                                if (responseData.status != "OK") {
                                  return DiscussionForumPage(
                                      discussionList: null);
                                }
                                List<Discussion> discussionList =
                                    responseData.list!;
                                if (user != null) {
                                  for (var disc in discussions) {
                                    disc.updateVote(user.username);
                                  }
                                }
                                return DiscussionForumPage(
                                    discussionList: discussionList);
                              } else {
                                return DiscussionForumPage(
                                    discussionList: null);
                              }
                          }
                        },
                      )),
            );
          },
        ),
        if (user != null)
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.pushNamed(context, settingsPage);
            },
          ),
        if (user != null)
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return logoutDialog(logout);
                },
              );
            },
          )
      ],
    ),
  );
}

BottomNavigationBar mainBottomBar(
    BuildContext context, CurrentUser? user, int currentIndex) {
  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.forum),
        label: 'Discussions',
      ),
    ],
    selectedItemColor: Colors.blue[600],
    enableFeedback: true,
    currentIndex: currentIndex,
    onTap: (index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FutureBuilder(
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
                            GetDiscussionListOutput responseData =
                                snapshot.data!;
                            if (responseData.status != "OK") {
                              return DiscussionForumPage(discussionList: null);
                            }
                            List<Discussion> discussionList =
                                responseData.list!;
                            if (user != null) {
                              for (var disc in discussions) {
                                disc.updateVote(user.username);
                              }
                            }
                            return DiscussionForumPage(
                                discussionList: discussionList);
                          } else {
                            return DiscussionForumPage(discussionList: null);
                          }
                      }
                    },
                  )),
        );
      }
    },
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logout() {
    setState(() {
      Provider.of<UserProvider>(context, listen: false).logout();
      Navigator.pop(context); // close pop up
      Navigator.pop(context); // close drawer
    });
  }

  Scaffold homePageScaffold(
      CurrentUser? user, List<PostAndImages> post_image_list) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        mainAppBar(context, user),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return FeedContainer(post_and_images: post_image_list[index]);
            },
            childCount: post_image_list.length,
          ),
        ),
      ]),
      drawer: mainDrawer(context, user, logout),
      bottomNavigationBar: mainBottomBar(context, user, 0),
    );
  }

  Scaffold erroneousHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
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
      future: getGenericPost(),
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
              GetPostListOutput responseData = snapshot.data!;
              if (responseData.status != "OK") {
                return erroneousHomePage();
              }
              List<Post> postList = responseData.list!;
              List<PostAndImages> post_image_list = [];
              for (var post in postList) {
                post_image_list.add(PostAndImages(post: post));
              }
              return homePageScaffold(user, post_image_list);
            } else {
              // snapshot.data == null
              return erroneousHomePage();
            }
        }
      },
    );
  }
}
