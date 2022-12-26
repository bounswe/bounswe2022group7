import 'package:flutter/material.dart';

Widget annotatedImage(
    Widget imageBuilderResult, List<Map<String, dynamic>> annotations) {
  // Used for showing the annotations on the image.

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
        child: annotation["text"] != null && annotation["text"] != ""
            ? Container(
                width: annotation["width"],
                height: 12,
                color: Colors.red,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        annotation["text"],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 8),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
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
                                        builder:
                                            (context, containsText, child) =>
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
                                                      ? const Text("Edit Text")
                                                      : const Text(
                                                          "Add Text to Annotation"),
                                            ),
                                            content: Form(
                                              key: formKey,
                                              child: TextField(
                                                controller:
                                                    annotationTextController,
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
                                                  formKey.currentState!.save();
                                                  annotation.value!["text"] =
                                                      annotationTextController
                                                          .text
                                                          .trim();
                                                  if (annotation
                                                          .value!["text"] !=
                                                      "") {
                                                    containsTextNotifier.value =
                                                        true;
                                                  } else {
                                                    containsTextNotifier.value =
                                                        false;
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
                        builder: (context, containsText, child) => containsText
                            ? Container(
                                width: value["width"],
                                height: 12,
                                color: Colors.red,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        annotation.value!["text"],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 8),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
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

ValueListenableBuilder<int> buildAnnotatableImage(
  Widget imageBuilderResult,
  ValueNotifier<int> annotationModeNotifier,
  ValueNotifier<Map<String, dynamic>?> annotationNotifier,
  ValueNotifier<List<Map<String, dynamic>>> annotationListNotifier,
) {
  return ValueListenableBuilder(
      valueListenable: annotationModeNotifier,
      builder: (context, value, child) {
        if (value == 0) {
          return imageBuilderResult;
        } else if (value == 1) {
          return ValueListenableBuilder(
              valueListenable: annotationListNotifier,
              builder: (context, annotationList, child) {
                return annotatedImage(imageBuilderResult, annotationList);
              });
        } else {
          return annotatableImage(imageBuilderResult, annotationNotifier);
        }
      });
}
