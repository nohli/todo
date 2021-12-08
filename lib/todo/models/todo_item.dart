class TodoItem {
  int userId;
  int id;
  String title;
  bool completed;

  TodoItem({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  TodoItem copyWith(userId, id, title, completed) {
    return TodoItem(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

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
}
