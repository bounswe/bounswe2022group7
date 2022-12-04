import 'package:flutter/material.dart';
import 'package:android/widgets/form_widgets.dart';
import 'package:android/network/comment/post_comment_input.dart';
import 'package:android/network/comment/post_comment_service.dart';
import 'package:android/models/comment/comment_model.dart';
import 'package:android/data/data.dart';
import 'dart:convert';
import 'package:android/widgets/profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class CommentWidget extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String comment = "";
  int postid;

  CommentWidget({super.key, required this.postid});

  void leaveComment() async {
    if (comment == "") {
      return;
    }
    print("comment: $comment of post $postid");

    postCommentInfo info = postCommentInfo(text: comment, postid: postid);
    int status = await postCommentNetwork(info);

    print("status: $status");
    if (status == 200) {
      controller.clear();
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

List<Comment> comments = [];

class CommentListWidget extends StatefulWidget {
  final List<Comment> commentList;

  CommentListWidget({Key? key, required this.commentList}) : super(key: key) {
    comments = commentList;
  }

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        Duration difference =
            DateTime.now().difference(comments[index].lastEditDate);
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
          // decoration: BoxDecoration(
          //     shape: BoxShape.rectangle,
          //     border: Border.all(width: 0.25),
          //     borderRadius: BorderRadius.circular(4)),
          child: Column(
            children: [
              Row(
                children: [
                  comments[index].authorAccountInfo.profile_picture_id == null
                      ? CircleAvatar(
                          radius: 12.0,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              MemoryImage(base64Decode(defaultbase64)),
                        )
                      : profilePictureWidget(
                          pictureid: comments[index]
                              .authorAccountInfo
                              .profile_picture_id!),
                  const Padding(padding: EdgeInsets.all(4.0)),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Text(
                          "${comments[index].authorAccountInfo.username} wrote $time_passed",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blueGrey.shade300),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Text(comments[index].text),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        iconSize: 20,
                        icon: Icon(
                          Icons.arrow_upward_outlined,
                          size: 20,
                          color: comments[index].liked!
                              ? Colors.red
                              : Colors.blueGrey.shade100,
                        ),
                        onPressed: () async {
                          setState(() {
                            comments[index].liked = !comments[index].liked!;
                            comments[index].disliked = false;
                          });
                        },
                      ),
                      // const Padding(padding: EdgeInsets.all(3.0)),
                      IconButton(
                        iconSize: 20,
                        icon: Icon(
                          Icons.arrow_downward_outlined,
                          size: 20,
                          color: comments[index].disliked!
                              ? Colors.red
                              : Colors.blueGrey.shade100,
                        ),
                        onPressed: () async {
                          setState(() {
                            comments[index].disliked =
                                !comments[index].disliked!;
                            comments[index].liked = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              // Row(
              //   children: [

              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }
}
