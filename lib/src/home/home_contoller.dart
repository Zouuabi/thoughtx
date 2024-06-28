import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:google_generative_ai/google_generative_ai.dart';

class HomeController with ChangeNotifier {
  List<Thought> thoughts = [];

  void addThought({required String content}) {
    thoughts.add(Thought(content: content));
    notifyListeners();
  }

  void removeThought({required int index}) {
    thoughts.removeAt(index);
    notifyListeners();
  }

  void generateTodo() async {
    final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: 'AIzaSyDlXVyAoI3ysGNhio2TgL-4LpCPPmK8zqQ');
    final content = [
      Content.text("""
these are my thoughts , i want you to list and summarize them from 
me and help me find out the connection between them
- Read the flutter documentations 
- Reorgnize code source that are puted in my portfolio website 
- make video presentation for them (in the portfolio) 
- Update the upwork account with these new videos 
- craft ideas about my final year project 
- revise Django course to be able to continue learning it 
- figure out how can i enhance my skills in flutter """)
    ];
    print('loading....');
    final response = await model.generateContent(content);
    print(response.text);
  }
}

class Thought {
  Thought({required this.content});
  final String content;
}
