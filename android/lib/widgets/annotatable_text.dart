import 'package:android/widgets/alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_selection_controls/text_selection_controls.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../util/annotation.dart';

late String text;
late TextStyle textStyle;

class AnnotatableText extends StatefulWidget {
  AnnotatableText(String t, {Key? key, required TextStyle style})
      : super(key: key) {
    text = t;
    textStyle = style;
  }

  @override
  State<AnnotatableText> createState() => _AnnotatableTextState();
}

class _AnnotatableTextState extends State<AnnotatableText> {
  final List<int> selections = List.filled(text.length, 0);
  // create 2d array of annotations
  final List<List<Annotation>> annotations = List.generate(
    text.length,
    (index) => List.empty(growable: true),
  );

  @override
  Widget build(BuildContext context) {
    CurrentUser? currentUser = Provider.of<UserProvider>(context).user;
    List<TextSpan> spans = [];
    void makeAnnotation(String body, int start, int end) {
      late Annotation a;
      if (currentUser!.username == null) {
        a = Annotation(body, currentUser.email, start, end);
      } else {
        a = Annotation(body, currentUser.username!, start, end);
      }
      setState(() {
        for (int i = start; i < end; i++) {
          selections[i] += 1;
          annotations[i].add(a);
        }
      });
    }

    for (int i = 0; i < text.length; i++) {
      spans.add(TextSpan(
        text: text[i],
        style: textStyle.copyWith(
          backgroundColor: selections[i] == 0
              ? null
              : selections[i] == 1
                  ? Colors.yellow
                  : Colors.amber,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            List<Annotation> annotationList = annotations[i];
            if (annotationList.length == 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return annotationDialog(
                      annotationList[0].body,
                      annotationList[0].author,
                    );
                  });
            } else if (annotationList.length > 1) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return multipleAnnotationDialog(annotationList, context);
                  });
            }
          },
      ));
    }
    return SelectableText.rich(
      TextSpan(
        style: textStyle,
        children: spans,
      ),
      style: textStyle,
      selectionControls: FlutterSelectionControls(toolBarItems: [
        ToolBarItem(
            item: const Text("Annotate"),
            onItemPressed: (String str, int start, int end) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return makeAnnotationDialog(makeAnnotation, start, end);
                },
              );
            }),
        ToolBarItem(
            item: const Icon(Icons.copy), itemControl: ToolBarItemControl.copy),
      ]),
    );
  }
}