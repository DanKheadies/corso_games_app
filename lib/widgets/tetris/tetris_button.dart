import 'package:flutter/material.dart';

class TetrisButton extends StatelessWidget {
  final double? iconOffset;
  final Function() onTap;
  final IconData icon;

  const TetrisButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: EdgeInsets.only(left: iconOffset!),
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}
