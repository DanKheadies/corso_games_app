import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NadDragObject extends StatelessWidget {
  const NadDragObject({
    Key? key,
    required this.id,
    required this.left,
    required this.top,
    required this.size,
    required this.text,
    required this.color,
    required this.canAccept,
    required this.canDrag,
    required this.onTapDown,
    required this.onTapUp,
    required this.changePositions,
  }) : super(key: key);

  final String id;
  final double left;
  final double top;
  final double size;
  final String text;
  final Color color;
  final bool canAccept;
  final bool canDrag;
  final Function(String) onTapDown;
  final Function(String) onTapUp;
  final Function(Object, String) changePositions;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 150),
      left: left,
      top: top,
      child: InkWell(
        onTap: canDrag ? () => onTapDown(id) : () {},
        onTapDown: canDrag ? (_) => onTapDown(id) : (_) {},
        child: Stack(
          children: [
            canAccept
                ? DragTarget(
                    builder: ((context, candidateData, rejectedData) {
                      return NadCircle(
                        isOpaque: false,
                        size: size,
                        color: color,
                        text: text,
                      );
                    }),
                    onWillAccept: (incoming) {
                      // print(data);
                      // print('$id will accept $incoming');
                      changePositions(incoming ?? {}, id);
                      return incoming == id;
                    },
                    onAccept: (data) {
                      // print('$id accepted $data');
                    },
                    onLeave: (data) {
                      // print('$data left $id');
                    },
                  )
                : Draggable<String>(
                    data: id,
                    onDragStarted: canDrag ? () => onTapDown(id) : () {},
                    feedback: canDrag
                        ? NadCircle(
                            isOpaque: true,
                            isExtraOpqaue: true,
                            size: size,
                            color: color,
                            text: text,
                          )
                        : const SizedBox(),
                    childWhenDragging: NadCircle(
                      isOpaque: true,
                      size: size,
                      color: color,
                      text: text,
                    ),
                    onDragEnd: canDrag ? (_) => onTapUp(id) : (_) {},
                    child: NadCircle(
                      isOpaque: false,
                      size: size,
                      color: color,
                      text: text,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
