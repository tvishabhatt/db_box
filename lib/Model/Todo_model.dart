class Todo {
  int? id;
  String task;
  bool isFavorite;

  Todo({
    this.id,
    required this.task,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      task: map['task'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}