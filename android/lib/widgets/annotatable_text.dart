import 'package:flutter/material.dart';
import 'package:text_selection_controls/text_selection_controls.dart';

late String text;

class AnnotatableText extends StatefulWidget {
  AnnotatableText(String t, {Key? key}) : super(key: key) {
    text = t;
  }

  @override
  State<AnnotatableText> createState() => _AnnotatableTextState();
}

class _AnnotatableTextState extends State<AnnotatableText> {
  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      selectionControls: FlutterSelectionControls(toolBarItems: [
        ToolBarItem(item: const Text("Annotate"), onItemPressed: (String str, int s, int e) {
          print(str);
          print(s);
          print(e);
        }),
        ToolBarItem(item: const Icon(Icons.copy), itemControl: ToolBarItemControl.copy),
      ]),
    );
  }
}
