import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onClosePressed;

  const ConfirmationDialog({Key? key, required this.onClosePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Відхилити вибір?'),
      content: const Text('Ви хочете відхилити вибір?'),
      actions: [
        TextButton(
          child: const Text('Скасувати'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          onPressed: onClosePressed,
          child: const Text('Відхилити'),
        ),
      ],
    );
  }
}
