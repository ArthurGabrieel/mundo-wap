part of 'app_route.dart';

enum Routes {
  login('/auth'),
  tasks('/tasks'),
  taskExecution('/task-execution');

  const Routes(this.path);

  final String path;
}
