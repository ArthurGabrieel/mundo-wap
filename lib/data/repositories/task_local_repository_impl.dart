import 'dart:convert';

import 'package:result_dart/result_dart.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/local/task_local_data_source.dart';
import '../models/field_model.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  AsyncResult<List<TaskEntity>> getTasks() async {
    final result = await localDataSource.getLastTasks();

    return result.fold(
      (taskModels) => Success(taskModels.cast<TaskEntity>().toList()),
      (failure) => Failure(failure),
    );
  }

  @override
  AsyncResult<Unit> saveTasks(List<TaskEntity> tasks) async {
    final taskModels =
        tasks.map((task) {
          return TaskModel(
            id: task.id,
            taskName: task.taskName,
            description: task.description,
            fields:
                task.fields
                    .map(
                      (field) => FieldModel(
                        id: field.id,
                        label: field.label,
                        req: field.req,
                        fieldType: field.fieldType,
                      ),
                    )
                    .toList(),
            isCompleted: task.isCompleted,
          );
        }).toList();

    return localDataSource.cacheTasks(taskModels);
  }

  @override
  AsyncResult<Unit> updateTaskStatus(int taskId, bool isCompleted) async {
    return localDataSource.updateTaskStatus(taskId, isCompleted);
  }

  @override
  AsyncResult<TaskEntity> getTaskById(int taskId) async {
    final result = await localDataSource.getTaskById(taskId);

    return result.map((taskModel) => taskModel as TaskEntity);
  }

  @override
  AsyncResult<Unit> deleteTask(int taskId) async {
    return localDataSource.deleteTask(taskId);
  }

  @override
  AsyncResult<Map<String, dynamic>> getDraft(int taskId) async {
    final result = await localDataSource.getDraft(taskId);

    return result.fold(
      (draft) => Success(jsonDecode(draft)),
      (failure) => Failure(failure),
    );
  }

  @override
  AsyncResult<Unit> saveDraft(int taskId, Map<String, dynamic> formData) async {
    final fieldsJson = jsonEncode(formData);
    return localDataSource.saveDraft(taskId, fieldsJson);
  }

  @override
  AsyncResult<Unit> eraseDrafts() async {
    return localDataSource.eraseDrafts();
  }
}
