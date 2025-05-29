import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../data/datasources/local/task_local_data_source.dart';
import '../../../data/datasources/local/task_local_data_source_impl.dart';
import '../../../data/datasources/remote/auth_remote_data_source.dart';
import '../../../data/datasources/remote/auth_remote_data_source_impl.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../data/repositories/task_local_repository_impl.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/task_repository.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/task_usecases.dart';
import '../../../presentation/bloc/auth/auth_bloc.dart';
import '../../../presentation/bloc/task_execution/task_execution_bloc.dart';
import '../../../presentation/bloc/tasks/tasks_bloc.dart';
import '../../utils/session_manager.dart';

final sl = GetIt.instance;

Future<void> initDependecies() async {
  // Blocs
  sl.registerFactory(
    () => AuthBloc(loginUseCase: sl(), saveTasksUseCase: sl()),
  );

  sl.registerFactory(
    () => TasksBloc(
      getTasksUseCase: sl(),
      updateTaskStatusUseCase: sl(),
      deleteTaskUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => TaskExecutionBloc(
      getTaskByIdUseCase: sl(),
      updateTaskStatusUseCase: sl(),
      saveDraftUseCase: sl(),
      eraseDraftsUseCase: sl(),
      loadDraftUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetTasksUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskStatusUseCase(sl()));
  sl.registerLazySingleton(() => GetTaskByIdUseCase(sl()));
  sl.registerLazySingleton(() => SaveTasksUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton(() => SaveDraftUseCase(sl()));
  sl.registerLazySingleton(() => EraseDraftsUseCase(sl()));
  sl.registerLazySingleton(() => LoadDraftUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(localDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(),
  );

  // External Dependencies
  sl.registerLazySingleton(() => Dio());

  // Session Manager
  sl.registerLazySingleton<SessionManager>(
    () => SessionManager(authLocalDataSource: sl()),
  );
}
