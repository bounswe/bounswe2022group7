import 'package:flutter/material.dart';

class AnnotationPage extends StatefulWidget {
  const AnnotationPage({Key? key, required this.annotationList})
      : super(key: key);

  final List<Map<String, dynamic>> annotationList;

  @override
  _AnnotationPageState createState() => _AnnotationPageState();
}

class _AnnotationPageState extends State<AnnotationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Annotation Page"),
      ),
      body: ListView.builder(
          itemCount: widget.annotationList.length,
          itemBuilder: (context, index) {
            // return text and the annotated part of the source image:
            return Column(
              children: [
                Text(widget.annotationList[index]["text"]),
                widget.annotationList[index]["image"],
              ],
            );
          }),
    );
  }
}