import 'dart:convert';

class Task {
  String id;
  String title;
  String description;
  String date;
  bool completed;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.completed,
  });

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: json["dateTime"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "dateTime": date,
        "completed": completed,
      };
}
