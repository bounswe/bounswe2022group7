import 'package:android/network/art_item/post_art_item_like_bookmark_service.dart';
import 'package:android/network/reporting/report_input.dart';
import 'package:android/network/reporting/report_service.dart';
import 'package:android/providers/user_provider.dart';
import 'package:android/widgets/annotatable_text.dart';
import 'package:android/pages/profile_page.dart';
import 'package:android/widgets/form_widgets.dart';
import 'package:flutter/material.dart';

import "package:android/models/models.dart";
import 'package:provider/provider.dart';

import '../network/image/get_image_builder.dart';
import '../widgets/comment.dart';
import '../widgets/annotation_bar.dart';
import '../widgets/annotatable_image.dart';

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

  final reportController = TextEditingController();

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
    if (user != null) {
      for (var comment in currentArtItem!.commentList) {
        comment.updateStatus(user.username);
      }
    }
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
                                  icon: currentArtItem!.likeStatus == 0
                                      ? Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.black,
                                          size: 30.0,
                                        )
                                      : Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 30.0,
                                        )),
                              IconButton(
                                  onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Report Art Item'),
                                          content: inputField(TextField(
                                            controller: reportController,
                                            onChanged: (_) => {},
                                            keyboardType:
                                                TextInputType.multiline,
                                            minLines: 3,
                                            maxLines: 5,
                                            autofocus: false,
                                            decoration: const InputDecoration(
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              hintText:
                                                  'Your reasoning for reporting',
                                            ),
                                          )),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                ReportInput reportInput =
                                                    ReportInput(
                                                        artItemId:
                                                            currentArtItem!.id,
                                                        description:
                                                            reportController
                                                                .text);
                                                await reportNetwork(
                                                    reportInput);
                                                Navigator.pop(
                                                    context, 'Report');
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Art Item Reported!'),
                                                    content: const Text(
                                                        'Will be reviewed soon'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: const Text('Report'),
                                            ),
                                          ],
                                        ),
                                      ),
                                  icon: const Icon(
                                    Icons.report,
                                    color: Colors.black,
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
                          buildAnnotatableImage(
                            imageBuilderResult,
                            annotationModeNotifier,
                            annotationNotifier,
                            annotationListNotifier,
                          ),
                          const SizedBox(height: 10.0),
                          currentArtItem!.artItemInfo.imageId != null
                              ? AnnotationBar(
                              editable: user != null,
                              imageId: currentArtItem!.artItemInfo.imageId!,
                                  countNotifier: annotationCountNotifier,
                                  modeNotifier: annotationModeNotifier,
                                  annotationNotifier: annotationNotifier,
                                  annotationListNotifier:
                                      annotationListNotifier)
                              : const SizedBox.shrink(),
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
