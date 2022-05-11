import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  bool isDone;
  Todo._edit({
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
    return Todo._edit(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [id];
}
