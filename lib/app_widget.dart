import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/constants/app_messages.dart';
import 'core/config/injection/injection_container.dart';
import 'core/config/routes/app_route.dart';
import 'core/config/theme/app_theme.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/task_execution/task_execution_bloc.dart';
import 'presentation/bloc/tasks/tasks_bloc.dart';

class MundoWapApp extends StatelessWidget {
  const MundoWapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<TasksBloc>(create: (_) => sl<TasksBloc>()),
        BlocProvider<TaskExecutionBloc>(create: (_) => sl<TaskExecutionBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRoute.router,
        debugShowCheckedModeBanner: false,
        title: AppMessages.appName,
        theme: AppTheme.light,
      ),
    );
  }
}
