import 'package:flutter/material.dart';

class Size extends StatefulWidget {
  const Size({
    Key? key,
    required this.size,
  }) : super(key: key);

  final String size;

  @override
  State<Size> createState() => _SizeState();
}

class _SizeState extends State<Size> {
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
