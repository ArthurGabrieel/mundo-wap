import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/task_usecases.dart';
import './auth_event.dart';
import './auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SaveTasksUseCase saveTasksUseCase;

  AuthBloc({required this.loginUseCase, required this.saveTasksUseCase})
    : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final loginResult = await loginUseCase(event.username, event.password);

    await loginResult.fold(
      (user) async {
        final saveResult = await saveTasksUseCase(user.tasks);

        saveResult.fold(
          (success) => emit(AuthSuccess(user: user)),
          (failure) => emit(AuthSuccess(user: user)),
        );
      }, //
      (failure) async => emit(AuthFailure(message: failure.toString())),
    );
  }
}
