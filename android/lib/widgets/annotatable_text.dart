import 'package:flutter/material.dart';
import 'package:text_selection_controls/text_selection_controls.dart';

late String text;
late TextStyle textStyle;

class AnnotatableText extends StatefulWidget {
  AnnotatableText(String t, {Key? key, required TextStyle style}) : super(key: key) {
    text = t;
    textStyle = style;
  }

  @override
  State<AnnotatableText> createState() => _AnnotatableTextState();
}

class _AnnotatableTextState extends State<AnnotatableText> {
  final List<int> selections = List.filled(text.length, 0);
  int i = -1;
  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        style: textStyle,
        children: selections.map((e) {
          i++;
          if (e == 1) {
            return TextSpan(
                text: text[i],
                style: const TextStyle(backgroundColor: Colors.yellow),
            );
          } else if (e > 1) {
            return TextSpan(
                text: text[i],
                style: const TextStyle(backgroundColor: Colors.amber),
            );
          } else {
            return TextSpan(
                text: text[i],
            );
          }
        }).toList(),
      ),
      style: textStyle,
      selectionControls: FlutterSelectionControls(toolBarItems: [
        ToolBarItem(item: const Text("Annotate"), onItemPressed: (String str, int s, int e) {
          print(str);
          print(s);
          print(e);
          setState(() {
            for (int i = s; i < e; i++) {
              selections[i] += 1;
            }
            i = -1;
          });
        }),
        ToolBarItem(item: const Icon(Icons.copy), itemControl: ToolBarItemControl.copy),
      ]),
    );
  }
}
