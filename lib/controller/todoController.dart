import 'package:get/get.dart';

import '../models/todo.dart';

final dummyList = [];

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void addTodo(Todo todo) {
    todos.add(todo);
  }

  Function removeTodo(String id) {
    var removedTodoIndex = todos.indexWhere((todo) => todo.id == id);
    if (removedTodoIndex == -1) {
      return () => {};
    }
    var removedTodo = todos[removedTodoIndex];
    todos.removeAt(removedTodoIndex);

    return () {
      todos.insert(removedTodoIndex, removedTodo);
    };
  }

  void insertAt(Todo todo, int index) {
    if (index < 0 || index >= todos.length) {
      return;
    }
    todos.insert(index, todo);
  }

  void updateTodo(Todo todo) {
    int updatedTodoIndex = todos.indexOf(todo);
    if (updatedTodoIndex == -1) return;
    todos[updatedTodoIndex] = todo;
  }
}
