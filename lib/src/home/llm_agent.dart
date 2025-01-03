import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';

class LlmAgent {
  static final LlmAgent _instance = LlmAgent._internal();

  factory LlmAgent() => _instance;
  LlmAgent._internal() {
    model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: '',
        generationConfig: GenerationConfig(
            responseMimeType: 'application/json', responseSchema: schema),
        systemInstruction: Content.system(
            """You are an expert helping people orgnize their thoughts
             and transform them ito actionable tasks in a todo list
              1. Read the thoughts and generate and detailed description for them 
              2. Find the connection between them
              3. Generate a todo list from the thoughts
              4. Present each task with it's priority (low , medium , high)
              follow the suggested format of response please
            """));
  }
  late final GenerativeModel model;

  final List<Content> _state = [];

  final schema = Schema.object(
      properties: {
        "Description": Schema.string(),
        "Content": Schema.array(
            description: 'Todo List',
            items: Schema.object(properties: {
              'Title': Schema.string(
                  description: 'Title of the task', nullable: false),
              'Priority': Schema.string(
                description: "Priority of the task ('low', 'medium', 'high') ",
                nullable: false,
              ),
              'Description': Schema.string(
                  description: 'Description of the task ', nullable: false)
            }, requiredProperties: [
              'Title',
              'Priority',
              'Description'
            ])),
      },
      nullable: false,
      requiredProperties: ['Content', 'Description']);

  Future<ToTasksResponse> thoughtstoTasks(
      {required List<String> thoughts}) async {
    _state.add(Content.text(thoughts.toString()));
    List<Task> tasks = [];
    String description = '';
    final response = await model.generateContent(_state);
    if (response.text != null) {
      final json = jsonDecode(response.text!) as Map<String, dynamic>;
      description = json['Description'] as String;
      final tasksres = json['Content'] as List;
      tasks = tasksres
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList();
      // keep track of the state

      _state.add(Content.model([TextPart(response.text!)]));
    }

    return ToTasksResponse(description: description, tasks: tasks);
  }
}

class ToTasksResponse {
  final String description;
  final List<Task> tasks;

  ToTasksResponse({required this.description, required this.tasks});
}

class Task {
  Task(
      {required this.title, required this.description, required this.priority});

  final String title;
  final String description;
  final String priority;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['Title'],
      description: json['Description'],
      priority: json['Priority'],
    );
  }
}
