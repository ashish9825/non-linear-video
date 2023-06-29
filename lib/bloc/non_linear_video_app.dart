import 'package:flutter/material.dart';
import 'package:non_linear_video/non_linear_video_screen.dart';

class NonLinearVideoApp extends StatelessWidget {
  const NonLinearVideoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // The play button will redirect the user to video session screen.
            FloatingActionButton.large(
              elevation: 1,
              child: const Icon(Icons.play_arrow, size: 56),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NonLinearVideoScreen()));
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Let\'s Go!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
