import 'package:flutter/material.dart';

import "package:android/models/models.dart";
import "package:android/network/art_item/get_art_item_service.dart";
import "package:android/network/art_item/get_art_item_output.dart";

import '../network/image/get_image_builder.dart';

class ArtItemPage extends StatefulWidget {
  final int id;

  const ArtItemPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ArtItemPage> createState() => _ArtItemPageState();
}

class _ArtItemPageState extends State<ArtItemPage> {

  Scaffold erroneousArtItemPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Art Item"),
      ),
      body: const Center(
        child: Text("Art Item Not Found"),
      ),
    );
  }

  Widget annotatedImage(Widget imageBuilderResult, List<Map<String, double>> annotations){
    /*
       Used for showing the annotations on the image.
     */

    List<Widget> annotationWidgets = [];
    for (var annotation in annotations){
      annotationWidgets.add(
        Positioned(
          top: annotation["y"],
          left: annotation["x"],
          child: Container(
            width: annotation["width"],
            height: annotation["height"],
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        imageBuilderResult,
        ...annotationWidgets,
      ],
    );
  }

  GestureDetector annotatableImage(Widget imageBuilderResult) {
    /*
      Used for creating annotations.
     */

    return GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        print(details.toString());
      },
      onLongPressMoveUpdate: (details) {
        print("Image long pressed move update");
      },
      onLongPressEnd: (details) {
        print("Image long press ended");
      },
      child: imageBuilderResult,
    );
  }

  @override
  Widget build(BuildContext context) {
    // enum annotationMode { Hidden, View, Edit }
    final ValueNotifier<int> annotationModeNotifier = ValueNotifier(0);

    return FutureBuilder(
      future: getArtItemNetwork(widget.id),
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
              GetArtItemOutput responseData = snapshot.data!;
              if (responseData.status != "OK") {
                return erroneousArtItemPage();
              }
              ArtItem currentArtItem = responseData.artItem!;
              Widget imageBuilderResult =
                  imageBuilder(currentArtItem.artItemInfo.imageId);

              return Scaffold(
                appBar: AppBar(
                  title: const Text("Art Item"),
                  backgroundColor: Colors.blue[300],
                ),
                body: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.blue[50],
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Text(
                                            currentArtItem.artItemInfo.name,
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.bookmark_add_outlined,
                                                color: Colors.black,
                                                size: 30.0,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.brush_outlined,
                                            color: Colors.black,
                                            size: 20.0,
                                          ),
                                          Text(
                                            " by ${currentArtItem.creatorAccountInfo.username}",
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            Icons.category_outlined,
                                            color: Colors.black,
                                            size: 20.0,
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            currentArtItem.artItemInfo.category!
                                                .map((category) => category)
                                                .join(", "),
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15.0),
                                      ValueListenableBuilder(
                                          valueListenable:
                                              annotationModeNotifier,
                                          builder: (context, value, child) {
                                            if (value == 0) {
                                              return imageBuilderResult;
                                            } else if (value == 1) {
                                              return annotatedImage(
                                                  imageBuilderResult, [
                                                    {"x": 0.0, "y": 0.0, "width": 100.0, "height": 100.0},
                                                    {"x": 120.0, "y": 100.0, "width": 30.0, "height": 40.0},
                                                    {"x": 200.0, "y": 200.0, "width": 75.0, "height": 30.0},
                                              ]);
                                            } else {
                                              return annotatableImage(
                                                  imageBuilderResult);
                                            }
                                          }),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.image_outlined,
                                            color: Colors.black,
                                            size: 20.0,
                                          ),
                                          const SizedBox(width: 5.0),
                                          const Text(
                                            "3 image annotations",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                            ValueListenableBuilder(
                                                valueListenable:
                                                    annotationModeNotifier,
                                                builder: (context, value,
                                                    child) {
                                                  // hidden
                                                  if (value == 0){
                                                    return Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              annotationModeNotifier
                                                                  .value = 2;
                                                            },
                                                            icon: const Icon(
                                                              Icons.edit_outlined,
                                                              color: Colors.black,
                                                              size: 20.0,
                                                            )),
                                                        IconButton(
                                                            onPressed: () {
                                                              annotationModeNotifier
                                                                  .value = 1;
                                                            },
                                                            icon: const Icon(
                                                              Icons.visibility_outlined,
                                                              color: Colors.black,
                                                              size: 20.0,
                                                            )),
                                                      ],
                                                    );
                                                  }
                                                  // view
                                                  else if (value == 1) {
                                                    return Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              annotationModeNotifier
                                                                  .value = 2;
                                                            },
                                                            icon: const Icon(
                                                              Icons.edit_outlined,
                                                              color: Colors.black,
                                                              size: 20.0,
                                                            )),
                                                        IconButton(
                                                            onPressed: () {
                                                              annotationModeNotifier
                                                                  .value = 0;
                                                            },
                                                            icon: const Icon(
                                                              Icons.visibility_off_outlined,
                                                              color: Colors.black,
                                                              size: 20.0,
                                                            )),
                                                      ],
                                                    );
                                                  }
                                                  // create
                                                  else {
                                                    return Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              annotationModeNotifier
                                                                  .value = 0;
                                                            },
                                                            icon: const Icon(
                                                              Icons.cancel_outlined,
                                                              color: Colors.black,
                                                              size: 20.0,
                                                            )),
                                                        IconButton(
                                                            onPressed: () {
                                                              print("Annotation added!");
                                                              annotationModeNotifier
                                                                  .value = 1;
                                                            },
                                                            icon: const Icon(
                                                              Icons.check_circle_outline,
                                                              color: Colors.black,
                                                              size: 20.0,
                                                            )),
                                                      ],
                                                    );
                                                  }
                                                }),
                                        ],
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        currentArtItem.artItemInfo.description,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.tag_outlined,
                                            color: Colors.black,
                                            size: 20.0,
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            currentArtItem.artItemInfo.labels!
                                                .map((labels) => labels)
                                                .join(", "),
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5.0),
                                      const Divider(color: Colors.black),
                                      const SizedBox(height: 5.0),
                                      Row(
                                        children: [
                                          const Icon(Icons.chat, size: 13.0),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            // TODO: Add number of comments
                                            "Comments (0)",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.favorite_border,
                                                color: Colors.black,
                                                size: 30.0,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.share,
                                                color: Colors.black,
                                                size: 30.0,
                                              )),
                                        ],
                                      ),
                                    ])),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // snapshot.data == null
              return erroneousArtItemPage();
            }
        }
      },
    );
  }
}
