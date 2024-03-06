/// Task model
/// This model is used to create a task object
class Task {
  final String id, title;
  final bool taskDone;
  Task({
    required this.id,
    required this.title,
    required this.taskDone,
  });

  ///Converts the task object to a map
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'taskDone': taskDone,
      };

  ///Copies the task object with changing values
  Map<String, dynamic> copyWith({String? id, String? title, bool? taskDone}) =>
      {
        'id': id ?? this.id,
        'title': title ?? this.title,
        'taskDone': taskDone ?? this.taskDone,
      };

  ///Converts a map to a task object
  static Task fromJson(Map<String, dynamic> json) => Task(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      taskDone:
          json['taskDone'] == true || json['taskDone'] == 1 ? true : false);
}
