import 'package:meta/meta.dart';

class TodoItem {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoItem({
    int? userId,
    int? id,
    required this.title,
    bool? completed,
  })  : userId = userId ?? 1,
        id = id ?? DateTime.now().millisecondsSinceEpoch,
        completed = completed ?? false;

  factory TodoItem.fromJson(Map<String, dynamic> map) {
    return TodoItem(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  TodoItem copyWith({
    int? userId,
    int? id,
    String? title,
    bool? completed,
  }) {
    return TodoItem(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  @useResult
  TodoItem toggle() => copyWith(completed: !completed);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoItem &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          id == other.id &&
          title == other.title &&
          completed == other.completed;

  @override
  int get hashCode =>
      userId.hashCode ^ id.hashCode ^ title.hashCode ^ completed.hashCode;
}
