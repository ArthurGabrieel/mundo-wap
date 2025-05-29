import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/logger.dart';
import '../../models/task_model.dart';
import './task_local_data_source.dart';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  Database? _database;
  static const String _dbName = 'mundo_wap_tasks.db';
  static const String _tasksTable = 'tasks';
  static const String _draftsTable = 'form_drafts';

  static const String _colId = 'id';
  static const String _colTaskName = 'task_name';
  static const String _colDescription = 'description';
  static const String _colFieldsJson = 'fields_json';
  static const String _colIsCompleted = 'is_completed';

  AsyncResult<Database> get database async {
    if (_database != null) return Success(_database!);

    try {
      _database = await _initDatabase();
      return Success(_database!);
    } catch (e, s) {
      log.e('Erro ao inicializar banco de dados', error: e, stackTrace: s);
      return Failure(LocalStorageException());
    }
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tasksTable (
        $_colId INTEGER PRIMARY KEY,
        $_colTaskName TEXT NOT NULL,
        $_colDescription TEXT NOT NULL,
        $_colFieldsJson TEXT NOT NULL, 
        $_colIsCompleted INTEGER NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE $_draftsTable (
        $_colId INTEGER PRIMARY KEY,
        $_colFieldsJson TEXT NOT NULL
      )
      ''');
  }

  @override
  AsyncResult<Unit> cacheTasks(List<TaskModel> tasksToCache) async {
    final dbResult = await database;
    return dbResult.fold(
      (db) async {
        try {
          final batch = db.batch();
          batch.delete(_tasksTable);
          for (final task in tasksToCache) {
            batch.insert(
              _tasksTable,
              task.toDbMap(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
          await batch.commit(noResult: true);
          log.d('Tarefas cacheadas no banco de dados local.');
          return const Success(unit);
        } catch (e) {
          log.e('Erro ao cachear tarefas: ${e.toString()}');
          return Failure(
            LocalStorageException(
              message: 'Falha ao salvar tarefas localmente',
            ),
          );
        }
      }, //
      (failure) => Failure(failure),
    );
  }

  @override
  AsyncResult<List<TaskModel>> getLastTasks() async {
    final dbResult = await database;
    return dbResult.fold(
      (db) async {
        try {
          final List<Map<String, dynamic>> maps = await db.query(_tasksTable);

          if (maps.isEmpty) {
            return const Success([]);
          }

          final tasks = List.generate(maps.length, (i) {
            return TaskModel.fromDbMap(maps[i]);
          });

          return Success(tasks);
        } catch (e, s) {
          log.e('Erro ao buscar últimas tarefas', error: e, stackTrace: s);
          return Failure(
            LocalStorageException(message: 'Falha ao buscar tarefas locais'),
          );
        }
      }, //
      (failure) => Failure(failure),
    );
  }

  @override
  AsyncResult<Unit> updateTaskStatus(int taskId, bool isCompleted) async {
    final dbResult = await database;
    return dbResult.fold(
      (db) async {
        try {
          final count = await db.update(
            _tasksTable,
            {_colIsCompleted: isCompleted ? 1 : 0},
            where: '$_colId = ?',
            whereArgs: [taskId],
          );
          if (count > 0) {
            log.d(
              'Status da tarefa $taskId atualizado para $isCompleted no DB.',
            );
            return const Success(unit);
          } else {
            log.w('Tarefa $taskId não encontrada para atualização de status.');
            return Failure(
              LocalStorageException(
                message:
                    'Tarefa com ID $taskId não encontrada para atualização.',
              ),
            );
          }
        } catch (e) {
          log.e('Erro ao atualizar status da tarefa', error: e);
          return Failure(
            LocalStorageException(
              message: 'Falha ao atualizar status da tarefa',
            ),
          );
        }
      }, //
      (failure) => Failure(failure),
    );
  }

  @override
  AsyncResult<TaskModel> getTaskById(int taskId) async {
    final dbResult = await database;
    return dbResult.fold(
      (db) async {
        try {
          final List<Map<String, dynamic>> maps = await db.query(
            _tasksTable,
            where: '$_colId = ?',
            whereArgs: [taskId],
            limit: 1,
          );
          if (maps.isNotEmpty) {
            return Success(TaskModel.fromDbMap(maps.first));
          } else {
            return Failure(EmptyResultException());
          }
        } catch (e) {
          log.e('Erro ao buscar tarefa por ID', error: e);
          return Failure(
            LocalStorageException(message: 'Falha ao buscar tarefa por ID'),
          );
        }
      }, //
      (failure) => Failure(failure),
    );
  }

  @override
  AsyncResult<Unit> deleteTask(int taskId) async {
    final dbResult = await database;

    return dbResult.fold(
      (db) async {
        try {
          final count = await db.delete(
            _tasksTable,
            where: '$_colId = ?',
            whereArgs: [taskId],
          );
          if (count > 0) {
            log.d('Tarefa $taskId excluída do DB.');
            return const Success(unit);
          } else {
            log.w('Tarefa $taskId não encontrada para exclusão.');
            return Failure(
              LocalStorageException(
                message: 'Tarefa com ID $taskId não encontrada para exclusão.',
              ),
            );
          }
        } catch (e) {
          log.e('Erro ao excluir tarefa', error: e);
          return Failure(
            LocalStorageException(message: 'Falha ao excluir tarefa'),
          );
        }
      }, //
      (failure) => Failure(failure),
    );
  }

  @override
  AsyncResult<Unit> saveDraft(int taskId, String fieldsJson) async {
    final dbResult = await database;
    return dbResult.fold(
      (db) async {
        await db.insert(_draftsTable, {
          _colId: taskId,
          _colFieldsJson: fieldsJson,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
        return const Success(unit);
      }, //
      (failure) => Failure(failure),
    );
  }

  @override
  AsyncResult<String> getDraft(int taskId) async {
    final dbResult = await database;
    return dbResult.fold(
      (db) async {
        final result = await db.query(
          _draftsTable,
          where: '$_colId = ?',
          whereArgs: [taskId],
        );
        if (result.isNotEmpty) {
          return Success(result.first[_colFieldsJson] as String);
        }
        return Failure(EmptyResultException());
      }, //
      (failure) => Failure(failure),
    );
  }

  @override
  AsyncResult<Unit> eraseDrafts() async {
    final dbResult = await database;
    return dbResult.fold(
      (db) async {
        await db.delete(_draftsTable);
        log.d('Drafts erased from DB.');
        return const Success(unit);
      }, //
      (failure) => Failure(failure),
    );
  }
}
