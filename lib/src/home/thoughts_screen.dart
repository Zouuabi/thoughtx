import 'package:flutter/material.dart';
import 'package:thoughtx/src/home/llm_agent.dart';
import 'package:thoughtx/src/home/thought_item.dart';

class ThoughtsScreen extends StatelessWidget {
  final ToTasksResponse res;

  const ThoughtsScreen({super.key, required this.res});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                res.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              )),
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemCount: res.tasks.length,
              itemBuilder: (context, index) {
                final task = res.tasks[index];
                return ThoughtItem(
                    content:
                        "${task.title} : ${task.priority}  ${task.description}");
              },
            ),
          ),
        ],
      ),
    );
  }
}
