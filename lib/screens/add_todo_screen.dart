import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/controller/todoController.dart';

import '../models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  final String? id;

  const AddTodoScreen({Key? key, this.id}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _titleTextEditingController = TextEditingController();
  final _descTextEditingController = TextEditingController();
  Todo? _todo = null;

  String? get _titleErrorText {
    if (_titleTextEditingController.text.isEmpty) {
      return 'Title must not be empty';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    final todoController = Get.find<TodoController>();
    if (widget.id != null) {
      _todo = todoController.todos.firstWhere((todo) => todo.id == widget.id);
      if (_todo != null) {
        _titleTextEditingController.text = _todo!.title;
        _descTextEditingController.text = _todo!.description;
      }
    }
  }

  void _addTodo() {
    final todoController = Get.find<TodoController>();
    if (_titleErrorText != null) return;
    if (_todo != null) {
      return todoController.updateTodo(_todo!.copyWithId(
          title: _titleTextEditingController.text,
          description: _descTextEditingController.text));
    }
    todoController.addTodo(Todo(
        title: _titleTextEditingController.text,
        description: _descTextEditingController.text));
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _todo != null ? const Text('Edit todo') : const Text('Add todo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            decoration:
                InputDecoration(labelText: 'Title', errorText: _titleErrorText),
            textInputAction: TextInputAction.next,
            controller: _titleTextEditingController,
            onChanged: (_) {
              setState(() {});
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Description'),
            textInputAction: TextInputAction.done,
            controller: _descTextEditingController,
            maxLines: 10,
            onSubmitted: (_) => _addTodo(),
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _addTodo();
                    Get.back();
                  },
                  child: Text(
                    _todo != null ? 'Edit' : 'Add',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextEditingController.dispose();
    _descTextEditingController.dispose();
  }
}
