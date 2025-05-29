import 'package:equatable/equatable.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TasksEvent {}

class UpdateTaskStatus extends TasksEvent {
  final int taskId;
  final bool isCompleted;

  const UpdateTaskStatus({required this.taskId, required this.isCompleted});

  @override
  List<Object> get props => [taskId, isCompleted];
}

class DeleteTask extends TasksEvent {
  final int taskId;

  const DeleteTask({required this.taskId});

  @override
  List<Object> get props => [taskId];
}
