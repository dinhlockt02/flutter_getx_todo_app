import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/todo.dart';

final dummyList = [];

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  @override
  void onInit() {
    List? storedTodos = GetStorage().read<List>('todos');

    if (storedTodos != null) {
      todos = storedTodos.map((e) => Todo.fromJson(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
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
