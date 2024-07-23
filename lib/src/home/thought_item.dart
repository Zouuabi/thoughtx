import 'package:flutter/material.dart';

class ThoughtItem extends StatelessWidget {
  const ThoughtItem({
    super.key,
    required this.content,
    required this.animation,
  });

  final String content;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            color: const Color.fromARGB(50, 97, 97, 97),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color.fromARGB(121, 0, 0, 0),
              width: 3,
            )),
        child: Center(child: Text(content)),
      ),
    );
  }
}
