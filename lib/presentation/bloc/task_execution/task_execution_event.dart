import 'package:equatable/equatable.dart';

abstract class TaskExecutionEvent extends Equatable {
  const TaskExecutionEvent();

  @override
  List<Object> get props => [];
}

class LoadTaskDetails extends TaskExecutionEvent {
  final int taskId;

  const LoadTaskDetails({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

class UpdateFormFieldValue extends TaskExecutionEvent {
  final int taskId;
  final String fieldLabel;
  final dynamic value;

  const UpdateFormFieldValue({
    required this.fieldLabel,
    required this.value,
    required this.taskId,
  });

  @override
  List<Object> get props => [fieldLabel, value ?? '', taskId];
}

class SaveTaskExecution extends TaskExecutionEvent {
  final int taskId;
  final Map<String, dynamic> formData;

  const SaveTaskExecution({required this.taskId, required this.formData});

  @override
  List<Object> get props => [taskId, formData];
}

class EraseDrafts extends TaskExecutionEvent {}
