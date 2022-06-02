import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class GameButton extends StatefulWidget {
  const GameButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function() onPress;

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTapDown: (details) => {
        setState(() {
          isPressed = true;
        }),
      },
      child: NeumorphicButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              widget.icon,
              size: 0.1 * height,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              widget.title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 0.01875 * height,
              ),
            ),
          ],
        ),
        style: NeumorphicStyle(
          color: Theme.of(context).colorScheme.secondary,
          depth: isPressed ? -4 : 4,
          intensity: 2.5,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
        ),
        onPressed: widget.onPress,
      ),
    );
  }
}
