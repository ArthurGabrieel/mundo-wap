import 'dart:convert';

import '../../domain/entities/task_entity.dart';
import '../../domain/entities/user_entity.dart';
import './task_model.dart';
import 'field_model.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.profile,
    required List<TaskModel> tasks,
  }) : super(tasks: tasks.map((taskModel) => taskModel as TaskEntity).toList());

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>?;
    if (userJson == null) {
      throw const FormatException(
        "Formato JSON inválido: objeto 'user' não encontrado.",
      );
    }

    final tasksList = userJson['tasks'] as List?;
    final List<TaskModel> tasks =
        tasksList != null
            ? tasksList
                .map((i) => TaskModel.fromJson(i as Map<String, dynamic>))
                .toList()
            : [];

    return UserModel(
      name: userJson['name'] as String,
      profile: userJson['profile'] as String,
      tasks: tasks,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profile': profile,

      'tasks':
          tasks
              .map(
                (task) =>
                    TaskModel(
                      id: task.id,
                      taskName: task.taskName,
                      description: task.description,
                      fields:
                          task.fields
                              .map(
                                (field) => FieldModel(
                                  id: field.id,
                                  label: field.label,
                                  req: field.req,
                                  fieldType: field.fieldType,
                                ),
                              )
                              .toList(),
                      isCompleted: task.isCompleted,
                    ).toJson(),
              )
              .toList(),
    };
  }

  factory UserModel.fromDbMap(Map<String, dynamic> map) {
    List<TaskModel> tasks = [];
    if (map['tasks_json'] != null) {
      final tasksJsonList = jsonDecode(map['tasks_json'] as String) as List;

      tasks =
          tasksJsonList
              .map((i) => TaskModel.fromJson(i as Map<String, dynamic>))
              .toList();
    }

    return UserModel(
      name: map['name'] as String,
      profile: map['profile'] as String,
      tasks: tasks,
    );
  }

  Map<String, dynamic> toDbMap() {
    final String tasksJson = jsonEncode(
      tasks
          .map(
            (task) =>
                TaskModel(
                  id: task.id,
                  taskName: task.taskName,
                  description: task.description,
                  fields:
                      task.fields
                          .map(
                            (field) => FieldModel(
                              id: field.id,
                              label: field.label,
                              req: field.req,
                              fieldType: field.fieldType,
                            ),
                          )
                          .toList(),
                  isCompleted: task.isCompleted,
                ).toJson(),
          )
          .toList(),
    );

    return {'name': name, 'profile': profile, 'tasks_json': tasksJson};
  }
}
