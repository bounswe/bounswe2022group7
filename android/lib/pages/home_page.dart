import 'package:android/config/app_routes.dart';
import 'package:android/pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:android/widgets/feed_container.dart';

import 'package:android/models/models.dart';
import 'package:android/data/data.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CurrentUser? user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: Colors.blue[300],
          title: const Text(
            'Art Community',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
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
                ? IconButton(
                    icon: const Icon(Icons.login),
                    iconSize: 30.0,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, login);
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.account_circle),
                    iconSize: 30.0,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(current_user: user),
                        ),
                      );
                    },
                  ),
          ],
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            final ArtItem artItem = artItems[index];
            final Event event = events[index];
            return FeedContainer(artItem: artItem, event: event);
          },
          childCount: artItems.length,
        )),
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
                children: [
                  Text(
                    "Art Community",
                    style: TextStyle(
                        color: Colors.white,
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
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),
            user != null
                ? ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                    onTap: () {
                      setState(() {
                        Provider.of<UserProvider>(context, listen: false)
                            .logout();
                        Navigator.pop(context); // close drawer
                      });
                    },
                  )
                : const SizedBox()
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
}
