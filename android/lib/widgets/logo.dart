import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(
          Icons.photo_camera_outlined,
          color: Colors.white,
          size: 150,
        ),
        // App Name
        const Text(
            'ideart.',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
        ),
      ],
    );
  }
}
