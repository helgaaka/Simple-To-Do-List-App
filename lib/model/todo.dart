class Todo {
  int? id;
  String? title;
  String? description;
  String? category;
  String? todoDate;
  int? isFinished;

  Todo({
    this.id,
    this.title,
    this.description,
    this.category,
    this.todoDate,
    this.isFinished,
  });

static mapToTodo(map) {
  Todo newTodo = Todo();
  newTodo.id = map['id'];
  newTodo.title = map['title'];
  newTodo.description = map['description'];
  newTodo.category = map['category'];
  newTodo.todoDate = map['todoDate'];
  newTodo.isFinished = map['isFinished'];
  return newTodo;
}
static todoToMap(item) {
  var mapping = <String, dynamic>{};
  mapping['id'] = item.id;
  mapping['title'] = item.title;
  mapping['description'] = item.description;
  mapping['category'] = item.category;
  mapping['todoDate'] = item.todoDate;
  mapping['isFinished'] = item.isFinished;
  return mapping;
}

}

