import 'package:equatable/equatable.dart';

import 'field_entity.dart';

class TaskEntity extends Equatable {
  final int id;
  final String taskName;
  final String description;
  final List<FieldEntity> fields;
  bool isCompleted;

  TaskEntity({
    required this.id,
    required this.taskName,
    required this.description,
    required this.fields,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [id, taskName, description, fields, isCompleted];
}
