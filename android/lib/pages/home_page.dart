import 'package:android/config/app_routes.dart';
import 'package:android/network/home/get_postlist_output.dart';
import 'package:android/pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:android/widgets/feed_container.dart';

import 'package:android/models/models.dart';
import 'package:provider/provider.dart';

import '../network/home/get_postlist_service.dart';
import '../providers/user_provider.dart';
import '../widgets/alert.dart';

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

  Scaffold homePageScaffold(CurrentUser? user, List<Post> postlist) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
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
                Navigator.pushNamed(context, '/search');
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
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return FeedContainer(post: postlist[index]);
            },
            childCount: postlist.length,
          ),
        ),
      ]),
      drawer: Drawer(
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
              onTap: () {},
            ),
            if (user != null)
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Profile"),
                onTap: () {},
              ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Online Galleries"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.museum),
              title: Text("Exhibitions"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text("Art Item Auctions"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.forum),
              title: Text("Discussion Page"),
              onTap: () {},
            ),
            if (user != null)
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {},
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Discussions',
          ),
        ],
        selectedItemColor: Colors.blue[600],
        enableFeedback: true,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            //Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            //Navigator.pushNamed(context, '/events');
          } else if (index == 2) {
            //Navigator.pushNamed(context, '/discussionPage');
          }
        },
      ),
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
              return homePageScaffold(user, postList);
            } else {
              // snapshot.data == null
              return erroneousHomePage();
            }
        }
      },
    );
  }
}
