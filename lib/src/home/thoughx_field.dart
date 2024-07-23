import 'package:flutter/material.dart';

class ThoughtxField extends StatefulWidget {
  const ThoughtxField({super.key, required this.onFinished});

  final void Function(String thought) onFinished;

  @override
  State<ThoughtxField> createState() => _ThoughtxFieldState();
}

class _ThoughtxFieldState extends State<ThoughtxField> {
  late final TextEditingController _thoughtController;

  bool isOnFinishEnabled = false;

  @override
  void initState() {
    _thoughtController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _thoughtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: 70,
      child: TextField(
        controller: _thoughtController,
        onChanged: (_) {
          setState(() {
            if (_thoughtController.text.trim().isEmpty) {
              isOnFinishEnabled = false;
            } else {
              isOnFinishEnabled = true;
            }
          });
        },
        decoration: InputDecoration(
            hintText: 'Write Your Thought',
            suffixIcon: IconButton(
                onPressed: isOnFinishEnabled
                    ? () {
                        widget.onFinished(_thoughtController.text.trim());
                        setState(() {
                          _thoughtController.clear();
                          isOnFinishEnabled = false;
                        });
                      }
                    : null,
                icon: Icon(
                  Icons.send,
                  color: isOnFinishEnabled ? Colors.teal : Colors.grey,
                )),
            filled: true,
            fillColor: const Color.fromARGB(50, 97, 97, 97),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
