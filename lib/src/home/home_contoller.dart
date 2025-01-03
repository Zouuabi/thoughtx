import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:thoughtx/src/home/llm_agent.dart';

class HomeController with ChangeNotifier {
  final agent = LlmAgent();
  List<String> thoughts = [];

  void addThought({required String content}) {
    thoughts.add(content);
    notifyListeners();
  }

  void removeThought({required int index}) {
    thoughts.removeAt(index);
    notifyListeners();
  }

  Future<ToTasksResponse> generateTodo() async {
    return await agent.thoughtstoTasks(thoughts: thoughts);
  }
}
