import 'package:equatable/equatable.dart';

import '../../../domain/entities/task_entity.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => [];
}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoadSuccess extends TasksState {
  final List<TaskEntity> tasks;

  const TasksLoadSuccess({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class TasksLoadFailure extends TasksState {
  final String message;

  const TasksLoadFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
