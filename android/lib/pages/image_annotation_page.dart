import 'package:flutter/material.dart';

import '../util/image.dart';

class AnnotationPage extends StatefulWidget {
  const AnnotationPage(
      {Key? key, required this.imageId, required this.annotationList})
      : super(key: key);

  final int imageId;
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
            final Map<String, dynamic> currentAnnotation =
                widget.annotationList[index];
            // return text and the annotated part of the source image:
            return Column(
              children: [
                Row(
                  children: [
                    Text(index.toString()),
                    FutureBuilder(
                      future: getSourceImage(widget.imageId,
                          MediaQuery.of(context).size.width - 24),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Scaffold(
                                appBar: AppBar(
                                  title: const Text("Snapshot Error!"),
                                ),
                                body: Center(
                                  child: Text("Error: ${snapshot.error}"),
                                ),
                              );
                            }
                            if (snapshot.data != null) {
                              if (snapshot.data! is Image) {
                                Image sourceImage = snapshot.data as Image;
                                return buildCroppedImage(
                                    sourceImage,
                                    currentAnnotation["x"],
                                    currentAnnotation["y"],
                                    currentAnnotation["width"],
                                    currentAnnotation["height"]);
                              } else {
                                return Scaffold(
                                  appBar: AppBar(
                                    title: const Text("Error with the Image!"),
                                  ),
                                  body: const Center(
                                    child: Text(
                                        "Could not fetch the image content."),
                                  ),
                                );
                              }
                            } else {
                              return Container();
                            }
                        }
                      },
                    ),
                    Text(currentAnnotation["text"]),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
