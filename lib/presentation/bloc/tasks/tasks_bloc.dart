import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/task_usecases.dart';
import './tasks_event.dart';
import './tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasksUseCase getTasksUseCase;
  final UpdateTaskStatusUseCase updateTaskStatusUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TasksBloc({
    required this.getTasksUseCase,
    required this.updateTaskStatusUseCase,
    required this.deleteTaskUseCase,
  }) : super(TasksInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<UpdateTaskStatus>(_onUpdateTaskStatus);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) async {
    emit(TasksLoading());

    final result = await getTasksUseCase();

    result.fold(
      (tasks) => emit(TasksLoadSuccess(tasks: tasks)),
      (failure) => emit(TasksLoadFailure(message: failure.toString())),
    );
  }

  Future<void> _onUpdateTaskStatus(
    UpdateTaskStatus event,
    Emitter<TasksState> emit,
  ) async {
    final result = await updateTaskStatusUseCase(
      event.taskId,
      event.isCompleted,
    );

    result.fold(
      (success) => add(LoadTasks()),
      (failure) => emit(TasksLoadFailure(message: failure.toString())),
    );
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    final result = await deleteTaskUseCase(event.taskId);

    result.fold(
      (success) => add(LoadTasks()),
      (failure) => emit(TasksLoadFailure(message: failure.toString())),
    );
  }
}
