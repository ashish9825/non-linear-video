import 'package:flutter/material.dart';

class AnalysingIndicator extends StatelessWidget {
  final String loadingMessage;
  const AnalysingIndicator({super.key, required this.loadingMessage});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 48),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children:  [
            Text(loadingMessage,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),
            const LinearProgressIndicator()
          ],
        ),
      ),
    );
  }
}
