import 'package:equatable/equatable.dart';

import '../../../domain/entities/task_entity.dart';

abstract class TaskExecutionState extends Equatable {
  const TaskExecutionState();

  @override
  List<Object?> get props => [];
}

class TaskExecutionInitial extends TaskExecutionState {}

class TaskExecutionLoading extends TaskExecutionState {}

class TaskExecutionLoadSuccess extends TaskExecutionState {
  final TaskEntity task;

  final Map<String, dynamic> formValues;

  const TaskExecutionLoadSuccess({
    required this.task,
    this.formValues = const {},
  });

  @override
  List<Object?> get props => [task, formValues];

  TaskExecutionLoadSuccess copyWith({
    TaskEntity? task,
    Map<String, dynamic>? formValues,
  }) {
    return TaskExecutionLoadSuccess(
      task: task ?? this.task,
      formValues: formValues ?? this.formValues,
    );
  }
}

class TaskExecutionLoadFailure extends TaskExecutionState {
  final String message;

  const TaskExecutionLoadFailure({required this.message});

  @override
  List<Object?> get props => [message];
}


class TaskExecutionSaveSuccess extends TaskExecutionState {}

class TaskExecutionSaveFailure extends TaskExecutionState {
  final String message;
  final TaskEntity task;
  final Map<String, dynamic> formValues;

  const TaskExecutionSaveFailure({
    required this.message,
    required this.task,
    required this.formValues,
  });

  @override
  List<Object?> get props => [message, task, formValues];
}
