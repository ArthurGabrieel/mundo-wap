import 'dart:convert';

import '../../domain/entities/field_entity.dart';
import '../../domain/entities/task_entity.dart';
import './field_model.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.taskName,
    required super.description,
    required List<FieldModel> fields,
    super.isCompleted,
  }) : super(
         fields: fields.map((fieldModel) => fieldModel as FieldEntity).toList(),
       );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final fieldsList = json['fields'] as List?;
    final List<FieldModel> fields =
        fieldsList != null
            ? fieldsList
                .map((i) => FieldModel.fromJson(i as Map<String, dynamic>))
                .toList()
            : [];

    return TaskModel(
      id: json['id'] as int,
      taskName: json['task_name'] as String,
      description: json['description'] as String,
      fields: fields,
      isCompleted: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_name': taskName,
      'description': description,
      'fields':
          fields
              .map(
                (field) =>
                    FieldModel(
                      id: field.id,
                      label: field.label,
                      req: field.req,
                      fieldType: field.fieldType,
                    ).toJson(),
              )
              .toList(),
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromDbMap(Map<String, dynamic> map) {
    List<FieldModel> fields = [];
    if (map['fields_json'] != null) {
      final fieldsJsonList = jsonDecode(map['fields_json'] as String) as List;
      fields =
          fieldsJsonList
              .map((i) => FieldModel.fromJson(i as Map<String, dynamic>))
              .toList();
    }

    return TaskModel(
      id: map['id'] as int,
      taskName: map['task_name'] as String,
      description: map['description'] as String,
      fields: fields,
      isCompleted: (map['is_completed'] as int) == 1,
    );
  }

  Map<String, dynamic> toDbMap() {
    final String fieldsJson = jsonEncode(
      fields
          .map(
            (field) =>
                FieldModel(
                  id: field.id,
                  label: field.label,
                  req: field.req,
                  fieldType: field.fieldType,
                ).toJson(),
          )
          .toList(),
    );

    return {
      'id': id,
      'task_name': taskName,
      'description': description,
      'fields_json': fieldsJson,
      'is_completed': isCompleted ? 1 : 0,
    };
  }
}
