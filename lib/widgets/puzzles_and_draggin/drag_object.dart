import 'package:flutter/material.dart';

class DragObject extends StatelessWidget {
  const DragObject({
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
        onTap: () => onTapDown(id),
        onTapDown: (_) => onTapDown(id),
        child: Stack(
          children: [
            canAccept
                ? DragTarget(
                    builder: ((context, candidateData, rejectedData) {
                      return Container(
                        height: size,
                        width: size,
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              // Non-selected circles
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            borderRadius: BorderRadius.circular(250),
                            color: color,
                          ),
                          child: const Center(
                              // child: text == '' ? const SizedBox() : Text(text),
                              ),
                        ),
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
                    onDragStarted: () => onTapDown(id),
                    feedback: Container(
                      height: size,
                      width: size,
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            // Dragging circle
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          borderRadius: BorderRadius.circular(250),
                          color: color.withOpacity(0.666),
                        ),
                        child: const Center(
                            // child: text == ''
                            //     ? const SizedBox()
                            //     : DefaultTextStyle(
                            //         style: const TextStyle(
                            //           fontSize: 20,
                            //           color: Colors.black,
                            //         ),
                            //         child: Text(text),
                            //       ),
                            ),
                      ),
                    ),
                    childWhenDragging: Container(
                      height: size,
                      width: size,
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            // Background / cast of moving circle
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.333),
                          ),
                          borderRadius: BorderRadius.circular(250),
                          color: color.withOpacity(0.333),
                        ),
                        child: const Center(
                            // child: text == '' ? const SizedBox() : Text(text),
                            ),
                      ),
                    ),
                    onDragEnd: (_) => onTapUp(id),
                    child: Container(
                      height: size,
                      width: size,
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            // Stationary border
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          borderRadius: BorderRadius.circular(250),
                          color: color,
                        ),
                        child: const Center(
                            // child: text == '' ? const SizedBox() : Text(text),
                            ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
