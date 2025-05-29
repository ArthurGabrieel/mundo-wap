import 'package:result_dart/result_dart.dart';

import '../entities/task_entity.dart';

abstract class TaskRepository {
  /// Salva a lista de tarefas localmente.
  /// Retorna [Result<Unit, Exception>] indicando sucesso ou falha.
  AsyncResult<Unit> saveTasks(List<TaskEntity> tasks);

  /// Obtém a lista de tarefas salvas localmente.
  /// Retorna [Result<List<TaskEntity>, Exception>] contendo a lista ou um erro.
  AsyncResult<List<TaskEntity>> getTasks();

  /// Atualiza o status de uma tarefa específica.
  /// Retorna [Result<Unit, Exception>] indicando sucesso ou falha.
  AsyncResult<Unit> updateTaskStatus(int taskId, bool isCompleted);

  /// Obtém uma tarefa específica pelo ID.
  /// Retorna [Result<TaskEntity?, Exception>] contendo a tarefa (ou null se não encontrada) ou um erro.
  AsyncResult<TaskEntity> getTaskById(int taskId);

  /// Exclui uma tarefa específica.
  /// Retorna [Result<Unit, Exception>] indicando sucesso ou falha.
  AsyncResult<Unit> deleteTask(int taskId);

  /// Salva um draft de tarefa no banco de dados local.
  /// Retorna [Result<Unit, Exception>] indicando sucesso ou falha.
  AsyncResult<Unit> saveDraft(int taskId, Map<String, dynamic> formData);

  /// Obtém um draft de tarefa no banco de dados local.
  /// Retorna [Result<String?, Exception>] contendo o draft (ou null se não encontrado) ou um erro.
  AsyncResult<Map<String, dynamic>> getDraft(int taskId);

  /// Exclui todos os drafts de tarefas no banco de dados local.
  /// Retorna [Result<Unit, Exception>] indicando sucesso ou falha.
  AsyncResult<Unit> eraseDrafts();
}
