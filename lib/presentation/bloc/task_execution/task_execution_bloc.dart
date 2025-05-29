import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/task_usecases.dart';
import './task_execution_event.dart';
import './task_execution_state.dart';

class TaskExecutionBloc extends Bloc<TaskExecutionEvent, TaskExecutionState> {
  final GetTaskByIdUseCase getTaskByIdUseCase;
  final UpdateTaskStatusUseCase updateTaskStatusUseCase;
  final SaveDraftUseCase saveDraftUseCase;
  final EraseDraftsUseCase eraseDraftsUseCase;
  final LoadDraftUseCase loadDraftUseCase;

  TaskExecutionBloc({
    required this.getTaskByIdUseCase,
    required this.updateTaskStatusUseCase,
    required this.saveDraftUseCase,
    required this.eraseDraftsUseCase,
    required this.loadDraftUseCase,
  }) : super(TaskExecutionInitial()) {
    on<LoadTaskDetails>(_onLoadTaskDetails);
    on<UpdateFormFieldValue>(_onUpdateFormFieldValue);
    on<SaveTaskExecution>(_onSaveTaskExecution);
    on<EraseDrafts>(_onEraseDrafts);
  }

Future<void> _onLoadTaskDetails(
    LoadTaskDetails event,
    Emitter<TaskExecutionState> emit,
  ) async {
    emit(TaskExecutionLoading());

    final result = await getTaskByIdUseCase(event.taskId);

    if (result.isSuccess()) {
      final task = result.getOrThrow();

      final draftResult = await loadDraftUseCase(event.taskId);

      if (draftResult.isSuccess()) {
        final draft = draftResult.getOrThrow();
        emit(TaskExecutionLoadSuccess(task: task, formValues: draft));
      } else {
        emit(TaskExecutionLoadSuccess(task: task, formValues: {}));
      }
    } else {
      emit(
        TaskExecutionLoadFailure(message: result.exceptionOrNull().toString()),
      );
    }
  }

  void _onUpdateFormFieldValue(
    UpdateFormFieldValue event,
    Emitter<TaskExecutionState> emit,
  ) async {
    if (state is TaskExecutionLoadSuccess) {
      final currentState = state as TaskExecutionLoadSuccess;
      final updatedFormValues = Map<String, dynamic>.from(
        currentState.formValues,
      );

      updatedFormValues[event.fieldLabel] = event.value;

      emit(currentState.copyWith(formValues: updatedFormValues));

      await saveDraftUseCase(event.taskId, updatedFormValues);
    }
  }

  Future<void> _onSaveTaskExecution(
    SaveTaskExecution event,
    Emitter<TaskExecutionState> emit,
  ) async {
    if (state is TaskExecutionLoadSuccess) {
      final currentState = state as TaskExecutionLoadSuccess;
      emit(TaskExecutionLoading());

      final statusUpdateResult = await updateTaskStatusUseCase(
        event.taskId,
        true,
      );

      statusUpdateResult.fold(
        (success) => emit(TaskExecutionSaveSuccess()),
        (failure) => emit(
          TaskExecutionSaveFailure(
            message: failure.toString(),
            task: currentState.task,
            formValues: currentState.formValues,
          ),
        ),
      );
    }
  }

  Future<void> _onEraseDrafts(
    EraseDrafts event,
    Emitter<TaskExecutionState> emit,
  ) async {
    await eraseDraftsUseCase();
  }
}
