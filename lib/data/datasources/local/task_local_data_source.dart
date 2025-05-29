import 'package:result_dart/result_dart.dart';

import '../../models/task_model.dart';

abstract class TaskLocalDataSource {
  /// Salva a lista de tarefas no banco de dados local.
  /// Retorna [Result<Unit, Exception>] indicando sucesso ou falha.
  AsyncResult<Unit> cacheTasks(List<TaskModel> tasksToCache);

  /// Obtém a lista de tarefas do banco de dados local.
  /// Retorna [Result<List<TaskModel>, Exception>] contendo a lista ou um erro.
  AsyncResult<List<TaskModel>> getLastTasks();

  /// Atualiza o status de uma tarefa específica no banco de dados local.
  /// Retorna [Result<Unit, Exception>] indicando sucesso ou falha.
  AsyncResult<Unit> updateTaskStatus(int taskId, bool isCompleted);

  /// Obtém uma tarefa específica pelo ID do banco de dados local.
  /// Retorna [Result<TaskModel, Exception>] contendo a tarefa (ou null se não encontrada) ou um erro.
  AsyncResult<TaskModel> getTaskById(int taskId);

  /// Exclui uma tarefa específica do banco de dados local.
  /// Retorna [Result<Unit, Exception>] indicando sucesso ou falha.
  AsyncResult<Unit> deleteTask(int taskId);

  /// Salva um draft de tarefa no banco de dados local.
  /// Retorna [Result<Unit, Exception>] indicando sucesso ou falha.
  AsyncResult<Unit> saveDraft(int taskId, String fieldsJson);

  /// Obtém um draft de tarefa no banco de dados local.
  /// Retorna [Result<String?, Exception>] contendo o draft (ou null se não encontrado) ou um erro.
  AsyncResult<String> getDraft(int taskId);

  /// Exclui todos os drafts de tarefas no banco de dados local.
  /// Retorna [Result<Unit, Exception>] indicando sucesso ou falha.
  AsyncResult<Unit> eraseDrafts();
}
