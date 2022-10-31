import 'package:android/models/art_item/art_item_creator_model.dart';
import 'package:android/pages/art_item_page.dart';
import 'package:android/pages/event_page.dart';
import 'package:flutter/material.dart';

class Post {
  final String type;
  final int id;
  final ArtItemCreator? creator;
  final String title;
  final String description;
  final String? imageUrl;

  Post({
    required this.type,
    required this.id,
    this.creator,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  Widget pageRoute() {
    if (type == "Event") {
      return EventPage(id: id);
    } else {
      return ArtItemPage(id: id);
    }
  }

  Widget titleRow() {
    return Row(
      children: [
        /*
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: NetworkImage(creator.imageUrl),
        ),
         */
        const SizedBox(width: 10.0),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4.0),
          if (creator != null)
            Row(
              children: [
                Icon(Icons.supervisor_account,
                    size: 12.0, color: Colors.grey[600]),
                const SizedBox(width: 5.0),
                Text("Host: ${creator?.name}"),
              ],
            )
        ]),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_add_outlined,
                color: Colors.black, size: 30.0)),
      ],
    );
  }

  Widget imageNetwork() {
    return imageUrl != null ? Image.network(imageUrl!) : Container();
  }

  Widget descriptionText() {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
