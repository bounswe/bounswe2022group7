import 'package:flutter/material.dart';
import 'package:android/pages/image_annotation_page.dart';

import 'package:android/network/annotation/post_annotation_service.dart';
import '../models/user_model.dart';
import 'package:android/util/snack_bar.dart';

class AnnotationBar extends StatelessWidget {
  const AnnotationBar({
    Key? key,
    this.user,
    required this.imageId,
    required this.countNotifier,
    required this.modeNotifier,
    required this.annotationNotifier,
    required this.annotationListNotifier,
  }) : super(key: key);

  final CurrentUser? user;
  final int imageId;
  final ValueNotifier<int> countNotifier;
  final ValueNotifier<int> modeNotifier;
  final ValueNotifier<Map<String, dynamic>?> annotationNotifier;
  final ValueNotifier<List<Map<String, dynamic>>> annotationListNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.sticky_note_2,
          color: Colors.black,
          size: 20.0,
        ),
        const SizedBox(width: 5.0),
        ValueListenableBuilder(
            valueListenable: countNotifier,
            builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnnotationPage(
                              imageId: imageId,
                              annotationList: annotationListNotifier.value)));
                },
                child: Text(
                  "$value image annotations",
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }),
        const Spacer(),
        ValueListenableBuilder(
            valueListenable: modeNotifier,
            builder: (context, value, child) {
              // hidden
              if (value == 0) {
                return Row(
                  children: [
                    user != null
                        ? IconButton(
                            onPressed: () {
                              modeNotifier.value = 2;
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Colors.black,
                              size: 20.0,
                            ))
                        : const SizedBox.shrink(),
                    IconButton(
                        onPressed: () {
                          modeNotifier.value = 1;
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
                    user != null
                        ? IconButton(
                            onPressed: () {
                              modeNotifier.value = 2;
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Colors.black,
                              size: 20.0,
                            ))
                        : const SizedBox.shrink(),
                    IconButton(
                        onPressed: () {
                          modeNotifier.value = 0;
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
                          modeNotifier.value = 0;
                        },
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.black,
                          size: 20.0,
                        )),
                    IconButton(
                        onPressed: () async {
                          if (annotationNotifier.value != null) {
                            annotationNotifier.value!["creator"] =
                                user!.username;
                            annotationNotifier.value!["imageId"] = imageId;
                            bool resp = await postImageAnnotation(annotationNotifier.value!);
                            if (resp) {
                              showSnackBar(context, "Annotation created");
                              annotationListNotifier.value
                                  .add(annotationNotifier.value!);
                              countNotifier.value++;
                            } else {
                              showSnackBar(context, "Failed to create annotation");
                            }
                            annotationNotifier.value = null;
                          }
                          modeNotifier.value = 1;
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
    );
  }
}
