import 'package:flutter/material.dart';

class Size extends StatelessWidget {
  const Size({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 24,
            bottom: 12,
          ),
          child: Text('score:'),
        ),
        Text(
          '',
          // model.value.toString(),
          // style: style,
        ),
      ],
    );
  }
}
