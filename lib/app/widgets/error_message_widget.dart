import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String error;
  final void Function() onRetry;
  const ErrorMessageWidget(
      {super.key, required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/warning.png', width: 72),
        const SizedBox(height: 16),
        Text(
          error,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Play Again'))
      ],
    );
  }
}
