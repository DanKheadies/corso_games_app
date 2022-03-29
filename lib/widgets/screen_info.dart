import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showScreenInfo(
  BuildContext context,
  String title,
  String text,
) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Column(
          children: [
            Text(title),
            const SizedBox(height: 10),
          ],
        ),
        content: Text(
          text,
          textAlign: TextAlign.left,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'Dismiss',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
