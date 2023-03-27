import 'package:flutter/material.dart';

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class CSWrapper extends StatefulWidget {
  final List<GamePiece> pieces;

  const CSWrapper({
    super.key,
    required this.pieces,
  });

  @override
  State<CSWrapper> createState() => _CSWrapperState();
}

class _CSWrapperState extends State<CSWrapper> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
