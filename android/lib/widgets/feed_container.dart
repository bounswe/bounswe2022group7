import 'package:flutter/material.dart';
import 'package:android/models/models.dart';

class FeedContainer extends StatelessWidget {
  final PostAndImages post_and_images;

  const FeedContainer({Key? key, required this.post_and_images})
      : super(key: key);

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
                  builder: (context) => post_and_images.post.pageRoute(),
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
                          child: post_and_images.infoColumn(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    post_and_images.image,
                    const SizedBox(height: 10.0),
                    post_and_images.post.descriptionText(),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
            ])));
  }
}
