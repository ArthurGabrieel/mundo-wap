import 'package:result_dart/result_dart.dart';

import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  /// Executa o caso de uso para obter as tarefas.
  /// Retorna [Result<List<TaskEntity>, Exception>].
  AsyncResult<List<TaskEntity>> call() async {
    return repository.getTasks();
  }
}

/// Caso de uso para atualizar o status de uma tarefa.
class UpdateTaskStatusUseCase {
  final TaskRepository repository;

  UpdateTaskStatusUseCase(this.repository);

  /// Executa o caso de uso para atualizar o status da tarefa.
  /// Retorna [Result<Unit, Exception>].
  AsyncResult<Unit> call(int taskId, bool isCompleted) async {
    return repository.updateTaskStatus(taskId, isCompleted);
  }
}

/// Caso de uso para obter uma tarefa específica pelo ID.
class GetTaskByIdUseCase {
  final TaskRepository repository;

  GetTaskByIdUseCase(this.repository);

  /// Executa o caso de uso para obter uma tarefa pelo ID.
  /// Retorna [Result<TaskEntity?, Exception>].
  AsyncResult<TaskEntity> call(int taskId) async {
    return repository.getTaskById(taskId);
  }
}

/// Caso de uso para salvar as tarefas localmente (geralmente após o login).
class SaveTasksUseCase {
  final TaskRepository repository;

  SaveTasksUseCase(this.repository);

  /// Executa o caso de uso para salvar a lista de tarefas.
  /// Retorna [Result<Unit, Exception>].
  AsyncResult<Unit> call(List<TaskEntity> tasks) async {
    return repository.saveTasks(tasks);
  }
}

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  /// Executa o caso de uso para excluir uma tarefa.
  /// Retorna [Result<Unit, Exception>].
  AsyncResult<Unit> call(int taskId) async {
    return repository.deleteTask(taskId);
  }
}

/// Caso de uso para salvar um draft de tarefa localmente (geralmente após o login).
class SaveDraftUseCase {
  final TaskRepository repository;

  SaveDraftUseCase(this.repository);

  /// Executa o caso de uso para salvar um draft de tarefa localmente.
  /// Retorna [Result<Unit, Exception>].
  AsyncResult<Unit> call(int taskId, Map<String, dynamic> formData) async {
    return repository.saveDraft(taskId, formData);
  }
}

class LoadDraftUseCase {
  final TaskRepository repository;

  LoadDraftUseCase(this.repository);

  /// Executa o caso de uso para obter um draft de tarefa.
  /// Retorna [Result<String?, Exception>].
  AsyncResult<Map<String, dynamic>> call(int taskId) async {
    return repository.getDraft(taskId);
  }
}

class EraseDraftsUseCase {
  final TaskRepository repository;

  EraseDraftsUseCase(this.repository);

  /// Executa o caso de uso para excluir todos os drafts de tarefas.
  /// Retorna [Result<Unit, Exception>].
  AsyncResult<Unit> call() async {
    return repository.eraseDrafts();
  }
}
