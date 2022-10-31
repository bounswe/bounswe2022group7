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
        title: Text(widget.artItem.name),
      ),
      body: Column(
        children: [
          Image.network(widget.artItem.imageUrl),
          Text(widget.artItem.name),
          Text(widget.artItem.artist.name),
          Text(widget.artItem.description),
        ],
      ),
    );
  }
}