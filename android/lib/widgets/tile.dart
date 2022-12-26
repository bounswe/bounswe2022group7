import 'package:android/config/app_routes.dart';
import 'package:android/models/discussion_model.dart';
import 'package:android/network/image/get_image_builder.dart';
import 'package:android/pages/art_item_page.dart';
import 'package:android/pages/discussion_page.dart';
import 'package:android/pages/event_page.dart';
import 'package:flutter/material.dart';
import 'package:android/models/models.dart';

class Tile extends StatelessWidget {
  final dynamic displayUnit;
  const Tile(this.displayUnit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 2;

    if (displayUnit is Event || displayUnit is ArtItem) {
      int image_id;
      try {
        image_id = (displayUnit as Event).eventInfo.imageId!;
      } catch (err) {
        image_id = (displayUnit as ArtItem).artItemInfo.imageId!;
      }
      return Stack(children: [
        OutlinedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => displayUnit is Event
                        ? EventPage(event: displayUnit as Event)
                        : ArtItemPage(
                            artItem: displayUnit as ArtItem,
                          )));
          },
          child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 0.75),
              ),
              width: width,
              child: imageBuilderWithSizeToFit(
                  image_id, width, MediaQuery.of(context).size.height)),
        ),
      ]);
    }

    return OutlinedButton(
      onPressed: () {
        print('dis on pressed');
      },
      child: Text("asds"),
      // child: Text(di!.textBody, style: Theme.of(context).textTheme.bodyText1),
    );
  }
}
