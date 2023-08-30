class TodoItem {
  final int userId;
  final int id;
  String title;
  bool isCompleted;

  TodoItem({int? userId, int? id, required this.title, bool? isCompleted})
      : userId = userId ?? 1,
        id = id ?? DateTime.now().millisecondsSinceEpoch,
        isCompleted = isCompleted ?? false;

  factory TodoItem.fromJson(Map<String, dynamic> map) {
    return TodoItem(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  TodoItem copyWith(userId, id, title, isCompleted) {
    return TodoItem(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  void toggle() => isCompleted = !isCompleted;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoItem &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          id == other.id &&
          title == other.title &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode =>
      userId.hashCode ^ id.hashCode ^ title.hashCode ^ isCompleted.hashCode;
}
