import 'package:go_router/go_router.dart';

import '../../../presentation/pages/login_page.dart';
import '../../../presentation/pages/task_execution_page.dart';
import '../../../presentation/pages/tasks_page.dart';

part 'route_list.dart';

class AppRoute {
  static final router = GoRouter(
    initialLocation: Routes.login.path,
    routes: [
      GoRoute(
        path: Routes.login.path,
        name: Routes.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.tasks.path,
        name: Routes.tasks.name,
        builder: (context, state) => const TasksPage(),
      ),
      GoRoute(
        path: Routes.taskExecution.path,
        name: Routes.taskExecution.name,
        builder: (context, state) {
          final taskId = state.extra as int;
          return TaskExecutionPage(taskId: taskId);
        },
      ),
    ],
  );
}
