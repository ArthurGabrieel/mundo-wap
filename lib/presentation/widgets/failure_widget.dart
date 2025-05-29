import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key, required this.message, required this.onRetry});

  final String message;
  final Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('Tentar Novamente'),
        ),
      ],
    );
  }
}
