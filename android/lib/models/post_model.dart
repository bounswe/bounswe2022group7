import 'package:flutter/material.dart';
import 'package:android/models/models.dart';
import 'package:android/network/image/get_image_builder.dart';
import 'package:android/pages/art_item_page.dart';
import 'package:android/pages/event_page.dart';

class Post {
  final String type;
  final int id;
  final AccountInfo creatorAccountInfo;
  final PostInfo postInfo;

  Post({
    required this.type,
    required this.id,
    required this.creatorAccountInfo,
    required this.postInfo,
  });

  Widget pageRoute() {
    if (type == "Event") {
      return EventPage(id: id);
    } else {
      return ArtItemPage(id: id);
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

class PostAndImages {
  final Post post;
  final Widget image;
  final Widget avatar;

  PostAndImages({
    required this.post,
  })  : image = post.imageNetwork(),
        avatar = circleAvatarBuilder(
            post.creatorAccountInfo.profile_picture_id, 20.0);

  Widget infoColumn() {
    if (post.type == "Event") {
      Event event = post as Event;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              avatar,
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  post.postInfo.name,
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
                    Text("Host: ${post.creatorAccountInfo.username}"),
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
              Text(event.location != null ? event.location!.address : ""),
            ],
          ),
        ],
      );
    } else {
      ArtItem artItem = post as ArtItem;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              avatar,
              const SizedBox(width: 10.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  post.postInfo.name,
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
                    Text("Artist: ${post.creatorAccountInfo.username}"),
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
          if (artItem.artItemInfo.category != null)
            Row(
              children: [
                Icon(
                  Icons.category,
                  color: Colors.grey[600],
                  size: 12.0,
                ),
                const SizedBox(width: 5.0),
                Text(
                  artItem.artItemInfo.category!.join(", "),
                ),
              ],
            ),
        ],
      );
    }
  }
}
