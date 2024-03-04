import 'package:flutter/material.dart';

class BirdScoreboard extends StatefulWidget {
  final double score;

  const BirdScoreboard({
    super.key,
    required this.score,
  });

  @override
  State<BirdScoreboard> createState() => _BirdScoreboardState();
}

class _BirdScoreboardState extends State<BirdScoreboard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Center(
          child: Stack(
            children: [
              Container(
                alignment: const Alignment(-0.5, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.score.toInt().toString(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 38,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'S C O R E',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: const Alignment(0.5, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '10',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 38,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'B E S T',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
