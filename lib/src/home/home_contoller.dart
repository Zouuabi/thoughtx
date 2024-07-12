import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:google_generative_ai/google_generative_ai.dart';

class HomeController with ChangeNotifier {
  List<Thought> thoughts = [];
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: 'AIzaSyDlXVyAoI3ysGNhio2TgL-4LpCPPmK8zqQ',
  );

  late final ChatSession chat;

  HomeController() {
    chat = model.startChat();
  }

  void addThought({required String content}) {
    thoughts.add(Thought(content: content));
    notifyListeners();
  }

  void removeThought({required int index}) {
    thoughts.removeAt(index);
    notifyListeners();
  }

  void generateTodo({required String message}) async {
    await chat.sendMessage(Content.text(message)).then(
      (response) {
        thoughts.add(Thought(content: response.text ?? 'Sorry fommi b trab'));
        notifyListeners();
      },
    );
  }
}

class Thought {
  Thought({required this.content});
  final String content;
}


//     final content = [
//       Content.text("""
// these are my thoughts , i want you to list and summarize them from
// me and help me find out the connection between them
// - Read the flutter documentations
// - Reorgnize code source that are puted in my portfolio website
// - make video presentation for them (in the portfolio)
// - Update the upwork account with these new videos
// - craft ideas about my final year project
// - revise Django course to be able to continue learning it
// - figure out how can i enhance my skills in flutter """)
//     ];
//     print('loading....');
//     final response = await model.generateContent(content);
//     print(response.text);

// * Read Flutter documentation
// * Reorganize code sources in my portfolio website
// * Make video presentations for portfolio projects
// * Update Upwork account with new videos
// * Craft final year project ideas
// * Revise Django course to continue learning
// * Enhance Flutter development skills

// Please reformulate them into clear tasks, organize them, assign a priority (High, Medium, Low) to each task, and provide the output in JSON format as shown below:

// {
//   "tasks": [
//     {"task": "Reformulated Task 1", "priority": "High"},
//     {"task": "Reformulated Task 2", "priority": "Medium"},
//     ...
//   ]
// }
