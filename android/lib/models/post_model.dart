import 'package:flutter/material.dart';
import 'package:android/models/models.dart';
import 'package:android/network/image/get_image_builder.dart';
import 'package:android/pages/art_item_page.dart';
import 'package:android/pages/event_page.dart';

class Post {
  final String type;
  final int id;
  final User creator;
  final PostInfo postInfo;

  Post({
    required this.type,
    required this.id,
    required this.creator,
    required this.postInfo,
  });

  Widget pageRoute() {
    if (type == "Event") {
      return EventPage(id: id);
    } else {
      return ArtItemPage(id: id);
    }
  }

  Widget infoColumn() {
    if (type == "Event") {
      Event event = this as Event;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[300],
                backgroundImage: NetworkImage(creator.imageUrl),
              ),
              const SizedBox(width: 10.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  postInfo.name,
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
                        size: 12.0, color: Colors.grey[600]),
                    const SizedBox(width: 5.0),
                    Text("Host: ${creator.name}"),
                  ],
                )
              ]),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_add_outlined,
                      color: Colors.black, size: 30.0)),
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
                event.eventInfo.startingDate.toString().substring(0, 16),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_pin,
                color: Colors.grey[600],
                size: 12.0,
              ),
              const SizedBox(width: 5.0),
              Text(event.location!.address),
            ],
          ),
        ],
      );
    } else {
      ArtItem artItem = this as ArtItem;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[300],
                backgroundImage: NetworkImage(creator.imageUrl),
              ),
              const SizedBox(width: 10.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  postInfo.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.brush_outlined,
                        size: 12.0, color: Colors.grey[600]),
                    const SizedBox(width: 5.0),
                    Text("Artist: ${creator.name}"),
                  ],
                )
              ]),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_add_outlined,
                      color: Colors.black, size: 30.0)),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Icon(
                Icons.category,
                color: Colors.grey[600],
                size: 12.0,
              ),
              const SizedBox(width: 5.0),
              Text(
                artItem.artItemInfo.category.toString(),
              ),
            ],
          ),
        ],
      );
    }
  }

  Widget imageNetwork() {
    return imageBuilder(postInfo.imageId);
  }

  Widget descriptionText() {
    return Text(
      postInfo.description,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
