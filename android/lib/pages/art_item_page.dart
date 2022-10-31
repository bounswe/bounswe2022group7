import 'package:flutter/material.dart';

import "package:android/models/models.dart";

class ArtItemPage extends StatefulWidget {
  final ArtItem artItem; // change this to int id later

  const ArtItemPage({Key? key, required this.artItem}) : super(key: key);

  @override
  State<ArtItemPage> createState() => _ArtItemPageState();
}

class _ArtItemPageState extends State<ArtItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.artItem.artItemInfo.name),
      ),
      body: Column(
        children: [
          widget.artItem.artItemInfo.imageUrl != null
              ? Image.network(widget.artItem.artItemInfo.imageUrl!)
              : Container(),
          Text(widget.artItem.creator.name),
          Text(widget.artItem.artItemInfo.description),
        ],
      ),
    );
  }
}