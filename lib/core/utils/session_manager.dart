import '../../data/datasources/local/task_local_data_source.dart';

class SessionManager {
  final TaskLocalDataSource authLocalDataSource;

  SessionManager({required this.authLocalDataSource});

  Future<bool> isLogged() async {
    final userResult = await authLocalDataSource.getLastTasks();
    return userResult.isSuccess();
  }
}
