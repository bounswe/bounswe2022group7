import 'package:flutter/material.dart';

class FormAppBar extends AppBar {
  FormAppBar({super.key});

  @override
  State<FormAppBar> createState() => _FormAppBarState();
}

class _FormAppBarState extends State<FormAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("ArtShare"),
      elevation: 0.1,
    );
  }
}
