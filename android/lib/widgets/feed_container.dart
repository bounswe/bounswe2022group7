import 'package:flutter/material.dart';
import 'package:android/models/models.dart';
import 'package:android/pages/event_page.dart';

class FeedContainer extends StatelessWidget {
  final Post post;

  const FeedContainer({Key? key, required this.post}) : super(key: key);

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
                  builder: (context) => post.pageRoute(),
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
                              post.titleRow(),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    post.imageNetwork(),
                    const SizedBox(height: 10.0),
                    post.descriptionText(),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
            ])));
  }
}
