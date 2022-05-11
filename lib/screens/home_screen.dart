import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/controller/todoController.dart';
import 'package:getx_todo_app/screens/add_todo_screen.dart';
import 'package:getx_todo_app/widgets/TodoItem.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoController = Get.put(TodoController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddTodoScreen());
        },
      ),
      body: Container(
        child: Obx(
          (() => todoController.todos.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.check,
                        size: 64,
                        color: Colors.green,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('You have complete all task! Congratulation'),
                    ],
                  ),
                )
              : ListView.separated(
                  itemBuilder: (_, todoIndex) => TodoItem(
                        todoIndex: todoIndex,
                      ),
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: todoController.todos.length)),
        ),
      ),
    );
  }
}
