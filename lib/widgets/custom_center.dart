import 'package:flutter/material.dart';

class CustomCenter extends StatelessWidget {
  final Widget child;

  const CustomCenter({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height - AppBar().preferredSize.height,
      child: Center(
        child: child,
      ),
    );
  }
}
