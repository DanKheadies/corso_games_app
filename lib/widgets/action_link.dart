import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ActionLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final bool resetLink;
  final bool isDisable;

  const ActionLink({
    super.key,
    required this.text,
    required this.onTap,
    required this.resetLink,
    required this.isDisable,
  });

  @override
  State<ActionLink> createState() => _ActionLinkState();
}

class _ActionLinkState extends State<ActionLink> {
  bool isClicked = false;
  late Timer _resetTimer = Timer(
    const Duration(milliseconds: 100),
    () {},
  );

  @override
  void initState() {
    super.initState();
  }

  void _runTimer() {
    _resetTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          isClicked = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _resetTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: isClicked
          ? Column(
              children: [
                const SizedBox(
                  height: 9,
                ),
                SizedBox(
                  width: 125,
                  child: LinearProgressIndicator(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                const SizedBox(height: 9),
              ],
            )
          : RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.text,
                    style: TextStyle(
                      color: isClicked || widget.isDisable
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        isClicked ? {} : widget.onTap();
                        if (widget.resetLink) {
                          _runTimer();
                        }
                        setState(() {
                          isClicked = true;
                        });
                      },
                  ),
                ],
              ),
            ),
    );
  }
}
