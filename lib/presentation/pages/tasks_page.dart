import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/theme/colors.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/tasks/tasks_bloc.dart';
import '../bloc/tasks/tasks_event.dart';
import '../bloc/tasks/tasks_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/failure_widget.dart';
import '../widgets/task_card.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  void initState() {
    super.initState();
    context.read<TasksBloc>().add(LoadTasks());
  }

  Widget _buildHeader() {
    final authState = context.watch<AuthBloc>().state;

    String userName = 'Usuário';
    if (authState is AuthSuccess) {
      userName = authState.user.name;
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: [
          const Icon(Icons.person, color: fontColorDark),
          const SizedBox(width: 8),
          Text(
            'Olá, $userName 👋',
            style: const TextStyle(
              color: fontColorDark,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'MundoWap Tarefas', isHome: true),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TasksLoadSuccess) {
            if (state.tasks.isEmpty) {
              return const Center(child: Text('Nenhuma tarefa encontrada.'));
            }

            return Column(
              children: [
                _buildHeader(),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder:
                        (_, index) => TaskCard(task: state.tasks[index]),
                  ),
                ),
              ],
            );
          }
          if (state is TasksLoadFailure) {
            return Center(
              child: FailureWidget(
                message: state.message,
                onRetry: () => context.read<TasksBloc>().add(LoadTasks()),
              ),
            );
          }
          return const Center(child: Text('Carregando tarefas...'));
        },
      ),
    );
  }
}
