import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/field_entity.dart';
import '../bloc/task_execution/task_execution_bloc.dart';
import '../bloc/task_execution/task_execution_event.dart';

class TaskFormFieldsWidget extends StatelessWidget {
  final int taskId;
  final List<FieldEntity> fields;
  final Map<String, TextEditingController> controllers;

  const TaskFormFieldsWidget({
    super.key,
    required this.fields,
    required this.controllers,
    required this.taskId,
  });

  TextInputType _getKeyboardType(String fieldType) {
    switch (fieldType) {
      case 'mask_price':
      case 'number':
        return TextInputType.numberWithOptions(
          decimal: fieldType == 'mask_price',
        );
      case 'mask_date':
        return TextInputType.datetime;
      case 'text':
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> formWidgets = [];
    for (var field in fields) {
      final controller = controllers[field.label];
      if (controller == null) {
        continue;
      }

      formWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: field.label),
            keyboardType: _getKeyboardType(field.fieldType),
            validator: (value) {
              if (field.req && (value == null || value.isEmpty)) {
                return 'Campo obrigatório';
              }
              return null;
            },
            onChanged: (value) {
              context.read<TaskExecutionBloc>().add(
                UpdateFormFieldValue(
                  fieldLabel: field.label,
                  value: value,
                  taskId: taskId,
                ),
              );
            },
          ),
        ),
      );
    }

    return Column(children: formWidgets);
  }
}
