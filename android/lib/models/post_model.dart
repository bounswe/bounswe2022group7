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

  Widget infoColumn() {
    if (type == "Event") {
      Event event = this as Event;
      Widget profileImg = imageBuilder(creatorAccountInfo.profile_picture_id);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              profileImg.toString() != "Container"
                  ? CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: (profileImg as Image).image,
                    )
                  : Container(),
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
                    Text("Host: ${creatorAccountInfo.username}"),
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
      ArtItem artItem = this as ArtItem;
      Widget profileImg = imageBuilder(creatorAccountInfo.profile_picture_id);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              profileImg.toString() != "Container"
                  ? CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: (profileImg as Image).image,
                    )
                  : Container(),
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
                    Text("Artist: ${creatorAccountInfo.username}"),
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
