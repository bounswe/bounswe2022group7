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
        title: const Text("Image Annotations"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 20.0,
          ),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FixedColumnWidth(32.0),
              1: FixedColumnWidth(85.0),
              2: FixedColumnWidth(120.0),
              3: FixedColumnWidth(105.0),
            },
            border: TableBorder.symmetric(
              inside: const BorderSide(color: Colors.grey, width: 0.5),
            ),
            children: [
              const TableRow(children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 2.0, top: 2.0, left: 2.0, right: 4.0),
                  child: Center(
                      child: Text("ID",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Center(
                      child: Text("Creator",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Center(
                    child: Text("Image",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 2.0, top: 2.0, left: 4.0, right: 2.0),
                  child: Center(
                    child: Text("Annotation",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ]),
              for (var annotation in widget.annotationList)
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(
    bottom: 2.0, top: 2.0, left: 2.0, right: 4.0),
                    child: Center(
                        child:
                            Text("${widget.annotationList.indexOf(annotation)}")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                        child: Text(
                      "${annotation['creator']}",
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: FutureBuilder(
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
                                      annotation["x"],
                                      annotation["y"],
                                      annotation["width"],
                                      annotation["height"],
                                      120,
                                      120);
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 2.0, top: 2.0, left: 4.0, right: 2.0),
                    child: Center(
                      child: Text(
                        annotation["text"] != "" ? annotation["text"] : "-",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ]),
            ],
          ),
        ),
      ),
    );
  }
}
