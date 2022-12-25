import 'package:android/network/art_item/post_art_item_like_bookmark_service.dart';
import 'package:android/providers/user_provider.dart';
import 'package:android/widgets/annotatable_text.dart';
import 'package:android/pages/profile_page.dart';
import 'package:flutter/material.dart';

import "package:android/models/models.dart";
import "package:android/network/art_item/get_art_item_service.dart";
import "package:android/network/art_item/get_art_item_output.dart";
import 'package:provider/provider.dart';

import '../network/image/get_image_builder.dart';
import '../widgets/comment.dart';

ArtItem? currentArtItem;

class ArtItemPage extends StatefulWidget {
  final ArtItem? artItem;

  ArtItemPage({Key? key, required this.artItem}) : super(key: key) {
    currentArtItem = artItem;
  }

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

  void navigateToHostProfile(_username) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(username: _username),
      ),
    );
  }

  Widget annotatedImage(
      Widget imageBuilderResult, List<Map<String, dynamic>> annotations) {
    /*
       Used for showing the annotations on the image.
     */

    List<Widget> annotationWidgets = [];
    for (var annotation in annotations) {
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

      annotationWidgets.add(
        Positioned(
          top: annotation["y"] + annotation["height"],
          left: annotation["x"],
          child: Container(
            width: annotation["width"],
            height: 20,
            color: Colors.red,
            child: Center(
              child: Text(
                annotation["text"],
                style: const TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
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

  GestureDetector annotatableImage(Widget imageBuilderResult,
      ValueNotifier<Map<String, dynamic>?> annotation) {
    /*
      Used for creating annotations. When the user starts to hold the image, the
      there will be a rectangle drawn on the image. The user can move the
      rectangle around the image. When the user releases the image, the
      rectangle will be saved as an annotation.
     */

    final formKey = GlobalKey<FormState>();
    final TextEditingController annotationTextController =
        TextEditingController();
    final containsTextNotifier = ValueNotifier<bool>(false);

    late Offset topLeft;

    return GestureDetector(
      onLongPressStart: (details) {
        topLeft = details.localPosition;
        annotation.value = {
          "x": topLeft.dx,
          "y": topLeft.dy,
          "width": 0.0,
          "height": 0.0,
          "text": "",
        };
      },
      onLongPressMoveUpdate: (details) {
        annotation.value = {
          // consider negative values
          "x": topLeft.dx < details.localPosition.dx
              ? topLeft.dx
              : details.localPosition.dx,
          "y": topLeft.dy < details.localPosition.dy
              ? topLeft.dy
              : details.localPosition.dy,
          "width": (topLeft.dx - details.localPosition.dx).abs(),
          "height": (topLeft.dy - details.localPosition.dy).abs(),
          "text": "",
        };
      },
      onLongPressEnd: (details) {},
      child: Stack(
        children: [
          imageBuilderResult,
          ValueListenableBuilder(
            valueListenable: annotation,
            builder: (context, value, child) => value == null
                ? Container()
                : Positioned(
                    top: value["y"],
                    left: value["x"],
                    child: Column(
                      children: [
                        Container(
                          width: value["width"],
                          height: value["height"],
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(),
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Container(
                                      width: 35,
                                      height: 35,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(5),
                                      child: IconButton(
                                        icon: ValueListenableBuilder(
                                          valueListenable: containsTextNotifier,
                                          builder: (context, containsText,
                                                  child) =>
                                              !containsText
                                                  ? const Icon(Icons.note_add,
                                                      color: Colors.red)
                                                  : const Icon(Icons.edit,
                                                      color: Colors.red),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: ValueListenableBuilder(
                                                valueListenable:
                                                    containsTextNotifier,
                                                builder: (context, containsText,
                                                        child) =>
                                                    containsText
                                                        ? const Text(
                                                            "Edit Text")
                                                        : const Text(
                                                            "Add Text to Annotation"),
                                              ),
                                              content: Form(
                                                key: formKey,
                                                child: TextField(
                                                  controller:
                                                      annotationTextController,
                                                  onSubmitted: (txt) {
                                                    annotation.value!["text"] =
                                                        txt;
                                                  },
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    formKey.currentState!
                                                        .save();
                                                    annotation.value!["text"] =
                                                        annotationTextController
                                                            .text;
                                                    if (annotation
                                                            .value!["text"] !=
                                                        "") {
                                                      containsTextNotifier
                                                          .value = true;
                                                    } else {
                                                      containsTextNotifier
                                                          .value = false;
                                                    }
                                                    Navigator.pop(context);
                                                  },
                                                  child: ValueListenableBuilder(
                                                    valueListenable:
                                                        containsTextNotifier,
                                                    builder: (context,
                                                            containsText,
                                                            child) =>
                                                        containsText
                                                            ? const Text("Edit")
                                                            : const Text("Add"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: containsTextNotifier,
                          builder: (context, containsText, child) =>
                              containsText
                                  ? Container(
                                      width: value["width"],
                                      height: 20,
                                      color: Colors.red,
                                      child: Center(
                                        child: Text(
                                          annotation.value!["text"],
                                          style: const TextStyle(
                                              color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                  : Container(),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentArtItem == null) {
      return erroneousArtItemPage();
    }
    CurrentUser? user = Provider.of<UserProvider>(context).user;
    // enum annotationMode { Hidden, View, Edit }
    final ValueNotifier<int> annotationModeNotifier = ValueNotifier(0);
    final ValueNotifier<Map<String, dynamic>?> annotationNotifier =
        ValueNotifier(null);

    final ValueNotifier<List<Map<String, dynamic>>> annotationListNotifier =
        ValueNotifier([]);
    final ValueNotifier<int> annotationCountNotifier = ValueNotifier(0);

    Widget imageBuilderResult =
        imageBuilder(currentArtItem!.artItemInfo.imageId);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Art Item"),
        backgroundColor: Colors.blue[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                currentArtItem!.artItemInfo.name,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    if (user != null) {
                                      final output =
                                          await postArtItemMarkNetwork(
                                              currentArtItem!.id, "bookmark");
                                      setState(() {
                                        if (output.artItem != null) {
                                          currentArtItem = output.artItem!;
                                          currentArtItem!
                                              .updateStatus(user.username);
                                        } else {
                                          if (currentArtItem!.bookmarkStatus ==
                                              0) {
                                            currentArtItem!.bookmarkStatus = 1;
                                          } else {
                                            currentArtItem!.bookmarkStatus = 0;
                                          }
                                        }
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.bookmark_add_outlined,
                                    color: currentArtItem!.bookmarkStatus == 0
                                        ? Colors.black
                                        : Colors.orange,
                                    size: 30.0,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    if (user != null) {
                                      final output =
                                          await postArtItemMarkNetwork(
                                              currentArtItem!.id, "like");
                                      setState(() {
                                        if (output.artItem != null) {
                                          currentArtItem = output.artItem!;
                                          currentArtItem!
                                              .updateStatus(user.username);
                                        } else {
                                          if (currentArtItem!.likeStatus == 0) {
                                            currentArtItem!.likeStatus = 1;
                                          } else {
                                            currentArtItem!.likeStatus = 0;
                                          }
                                        }
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: currentArtItem!.likeStatus == 0
                                        ? Colors.black
                                        : Colors.red,
                                    size: 30.0,
                                  )),
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                navigateToHostProfile(currentArtItem!
                                    .creatorAccountInfo.username);
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.brush_outlined,
                                    color: Colors.black,
                                    size: 20.0,
                                  ),
                                  Text(
                                    " by ${currentArtItem!.creatorAccountInfo.username}",
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
                                    currentArtItem!.artItemInfo.category!
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
                              )),
                          const SizedBox(height: 15.0),
                          ValueListenableBuilder(
                              valueListenable: annotationModeNotifier,
                              builder: (context, value, child) {
                                if (value == 0) {
                                  return imageBuilderResult;
                                } else if (value == 1) {
                                  return ValueListenableBuilder(
                                      valueListenable: annotationListNotifier,
                                      builder:
                                          (context, annotationList, child) {
                                        return annotatedImage(
                                            imageBuilderResult, annotationList);
                                      });
                                } else {
                                  return annotatableImage(
                                      imageBuilderResult, annotationNotifier);
                                }
                              }),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.sticky_note_2,
                                color: Colors.black,
                                size: 20.0,
                              ),
                              const SizedBox(width: 5.0),
                              ValueListenableBuilder(
                                  valueListenable: annotationCountNotifier,
                                  builder: (context, value, child) {
                                    return Text(
                                      "$value image annotations",
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  }),
                              const Spacer(),
                              ValueListenableBuilder(
                                  valueListenable: annotationModeNotifier,
                                  builder: (context, value, child) {
                                    // hidden
                                    if (value == 0) {
                                      return Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                annotationModeNotifier.value =
                                                    2;
                                              },
                                              icon: const Icon(
                                                Icons.edit_outlined,
                                                color: Colors.black,
                                                size: 20.0,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                annotationModeNotifier.value =
                                                    1;
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
                                                annotationModeNotifier.value =
                                                    2;
                                              },
                                              icon: const Icon(
                                                Icons.edit_outlined,
                                                color: Colors.black,
                                                size: 20.0,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                annotationModeNotifier.value =
                                                    0;
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
                                                annotationNotifier.value = null;
                                                annotationModeNotifier.value =
                                                    0;
                                              },
                                              icon: const Icon(
                                                Icons.cancel_outlined,
                                                color: Colors.black,
                                                size: 20.0,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                if (annotationNotifier.value !=
                                                    null) {
                                                  annotationListNotifier.value
                                                      .add(annotationNotifier
                                                          .value!);
                                                  annotationCountNotifier
                                                      .value++;
                                                  annotationNotifier.value =
                                                      null;
                                                }
                                                annotationModeNotifier.value =
                                                    1;
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
                          AnnotatableText(
                            currentArtItem!.artItemInfo.description,
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
                                currentArtItem!.artItemInfo.labels!
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
                                "Comments ${currentArtItem!.commentList.length}",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          // const Padding(padding: EdgeInsets.all(4.0)),
                          CommentListWidget(
                            commentList: currentArtItem!.commentList,
                          ),
                          const Padding(padding: EdgeInsets.all(4.0)),
                          CommentWidget(
                              postid: currentArtItem!.id, post_type: "artitem"),
                        ])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
