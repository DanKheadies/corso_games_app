import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showScreenInfo(
  BuildContext context,
  String title,
  String text,
  bool showGLHF,
  TextAlign? alignment,
  String button,
) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: showGLHF ? 0 : 15,
          ),
          child: showGLHF
              ? Column(
                  children: [
                    Text(
                      text,
                      textAlign: alignment ?? TextAlign.left,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Good luck, have fun!',
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Text(
                  text,
                  textAlign: alignment ?? TextAlign.left,
                ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              button,
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
