import 'package:android/models/art_item/art_item_model.dart';
import 'package:android/models/user_model.dart';
import 'package:android/network/art_item/get_art_item_output.dart';
import 'package:android/network/art_item/get_art_item_service.dart';
import 'package:android/network/comment/post_comment_vote_input.dart';
import 'package:android/network/comment/post_comment_vote_service.dart';
import 'package:android/network/event/get_event_output.dart';
import 'package:android/network/event/get_event_service.dart';
import 'package:android/network/image/get_image_builder.dart';
import 'package:android/providers/user_provider.dart';
import 'package:android/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:android/widgets/form_widgets.dart';
import 'package:android/network/comment/post_comment_input.dart';
import 'package:android/network/comment/post_comment_service.dart';
import 'package:android/models/comment/comment_model.dart';
import 'package:provider/provider.dart';

import '../models/event/event_model.dart';

// ignore: must_be_immutable
class CommentWidget extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String comment = "";
  int postid;
  String post_type;

  CommentWidget({super.key, required this.postid, required this.post_type});

  void leaveComment() async {
    if (comment == "") {
      print("empty commnet");
      return;
    }

    postCommentInfo info = postCommentInfo(text: comment, postid: postid);
    int status = await postCommentNetwork(info);

    if (status == 200) {
      controller.clear();
    }
    CurrentUser? user = await getUser();

    if (post_type == "event") {
      GetEventOutput geo = await getEventNetwork(postid);
      Event eve = geo.event!;
      comments.value = eve.commentList;
      if (user != null) {
        for (var comment in eve.commentList) {
          comment.updateStatus(user.username);
        }
      }
    } else if (post_type == "artitem") {
      GetArtItemOutput aio = await getArtItemNetwork(postid);
      ArtItem ai = aio.artItem!;
      comments.value = ai.commentList;
      if (user != null) {
        for (var comment in ai.commentList) {
          comment.updateStatus(user.username);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: inputField(
        TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.zero,
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            hintText: 'Leave a comment...',
            suffix: IconButton(
                onPressed: leaveComment,
                icon: const Icon(
                  Icons.send,
                )),
          ),
          onChanged: (value) => comment = value!,
          style: const TextStyle(fontSize: 17),
          showCursor: true,
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
    );
  }
}

var comments = ValueNotifier<List<Comment>>([]);

class CommentListWidget extends StatefulWidget {
  final List<Comment> commentList;

  CommentListWidget({Key? key, required this.commentList}) : super(key: key) {
    comments.value = commentList;
  }

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentListWidget> {
  @override
  Widget build(BuildContext context) {
    CurrentUser? user = Provider.of<UserProvider>(context).user;

    return ValueListenableBuilder(
      valueListenable: comments,
      builder: (context, value, widget) => ListView.builder(
        itemCount: comments.value.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Duration difference =
              DateTime.now().difference(comments.value[index].lastEditDate);
          String time_passed = "";
          if (difference.inDays != 0) {
            time_passed = "${difference.inDays} days ago";
          } else if (difference.inHours != 0) {
            time_passed = "${difference.inHours} hours ago";
          } else if (difference.inMinutes != 0) {
            time_passed = "${difference.inMinutes} mins ago";
          } else {
            time_passed = "now";
          }

          return SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    circleAvatarBuilder(
                        comments
                            .value[index].authorAccountInfo.profile_picture_id,
                        12.0),
                    const Padding(padding: EdgeInsets.all(4.0)),
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 160,
                          child: Text(
                            "${comments.value[index].authorAccountInfo.username} wrote $time_passed",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blueGrey.shade300),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 160,
                          child: Text(comments.value[index].text),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              if (user != null) {
                                final output = await postCommentVoteNetwork(
                                    PostCommentVoteInput(
                                        id: comments.value[index].id,
                                        vote: -1));
                                setState(() {
                                  if (output.comment != null) {
                                    comments.value[index] = output.comment!;
                                    comments.value[index]
                                        .updateStatus(user.username);
                                  } else {
                                    if (comments.value[index].voteStatus ==
                                        -1) {
                                      comments.value[index].voteStatus = 0;
                                    } else {
                                      comments.value[index]!.voteStatus = -1;
                                    }
                                  }
                                });
                              }
                            },
                            icon: Icon(Icons.arrow_downward,
                                color: comments.value[index].voteStatus == -1
                                    ? Colors.deepOrange
                                    : Colors.grey,
                                size: 20.0)),
                        IconButton(
                            onPressed: () async {
                              if (user != null) {
                                final output = await postCommentVoteNetwork(
                                    PostCommentVoteInput(
                                        id: comments.value[index].id, vote: 1));
                                setState(() {
                                  if (output.comment != null) {
                                    comments.value[index] = output.comment!;
                                    comments.value[index]
                                        .updateStatus(user.username);
                                  } else {
                                    if (comments.value[index].voteStatus == 1) {
                                      comments.value[index].voteStatus = 0;
                                    } else {
                                      comments.value[index].voteStatus = 1;
                                    }
                                  }
                                });
                              }
                            },
                            icon: Icon(Icons.arrow_upward,
                                color: comments.value[index].voteStatus == 1
                                    ? Colors.green
                                    : Colors.grey,
                                size: 20.0)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
