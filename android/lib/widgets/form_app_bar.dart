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
      title: const Text(
            'ideart.',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
      elevation: 0.1,
    );
  }
}
