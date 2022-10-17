import 'package:flutter/material.dart';

import 'package:android/widgets/feed_container.dart';

import 'package:android/models/models.dart';
import 'package:android/data/data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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

            IconButton(
              icon: const Icon(Icons.account_circle),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
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
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/events');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/discussionPage');
          }
        },
      ),
    );
  }
}


