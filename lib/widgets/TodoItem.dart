import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/controller/todoController.dart';
import 'package:getx_todo_app/screens/add_todo_screen.dart';

import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final int todoIndex;

  const TodoItem({Key? key, required this.todoIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoController>();
    final todo = todoController.todos[todoIndex];
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) {
        final undo = todoController.removeTodo(todo.id);
        if (Get.isSnackbarOpen) {
          Get.back();
        }
        Get.snackbar(
          'Deleted',
          'You have deleted ${todo.title}',
          mainButton: TextButton(
              onPressed: () {
                undo();
                Get.closeAllSnackbars();
              },
              child: const Text(
                'Undo',
                style: TextStyle(color: Colors.black),
              )),
        );
      },
      child: ListTile(
        onTap: () {
          Get.to(() => AddTodoScreen(id: todo.id));
        },
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (value) {
            todo.isDone = value ?? false;
            todoController.todos[todoIndex] = todo;
          },
        ),
        title: Text(
          todo.title,
          style: todo.isDone
              ? const TextStyle(
                  color: Colors.red,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 20)
              : const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
        ),
        subtitle: Text(
          todo.description,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
