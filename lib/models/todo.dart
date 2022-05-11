import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  bool isDone;
  Todo._withId({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });
  Todo({
    required this.title,
    required this.description,
    this.isDone = false,
  }) : id = const Uuid().v4();

  Todo copyWithId({String? title, String? description, bool? isDone}) {
    return Todo._withId(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [id];

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo._withId(
        title: json['title'],
        isDone: json['isDone'],
        description: json['description'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() =>
      {'title': title, 'description': description, 'isDone': isDone, 'id': id};
}
