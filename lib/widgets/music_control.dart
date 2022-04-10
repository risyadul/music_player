import 'package:flutter/material.dart';

class MusicControl extends StatelessWidget {
  const MusicControl(
      {Key? key,
      required this.duration,
      required this.setState,
      required this.isPausing,
      required this.startCallback,
      required this.position,
      required this.nextCallback,
      required this.previousCallback})
      : super(key: key);

  final Duration position;
  final bool isPausing;
  final Duration duration;
  final void Function(int, VoidCallback) setState;
  final VoidCallback startCallback;
  final VoidCallback nextCallback;
  final VoidCallback previousCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous),
                color: Colors.grey.shade600,
                iconSize: 30,
                onPressed: previousCallback,
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: isPausing
                    ? const Icon(Icons.play_arrow)
                    : const Icon(Icons.pause),
                color: Colors.grey.shade600,
                iconSize: 30,
                onPressed: startCallback,
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: Icon(Icons.skip_next),
                color: Colors.grey.shade600,
                iconSize: 30,
                onPressed: nextCallback,
              )
            ],
          ),
          Slider(
            value: position.inSeconds.toDouble(),
            min: 0.0,
            max: duration.inSeconds.toDouble(),
            onChanged: (double value) {
              setState(value.toInt(), (() => value = value));
            },
          )
        ],
      ),
    );
  }
}
