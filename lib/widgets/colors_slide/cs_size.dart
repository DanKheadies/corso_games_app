import 'package:flutter/material.dart';

class CSSize extends StatefulWidget {
  const CSSize({
    Key? key,
    required this.size,
  }) : super(key: key);

  final String size;

  @override
  State<CSSize> createState() => _CSSizeState();
}

class _CSSizeState extends State<CSSize> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 24,
            bottom: 12,
          ),
          child: Text('size:'),
        ),
        Text(
          widget.size,
        ),
      ],
    );
  }
}
