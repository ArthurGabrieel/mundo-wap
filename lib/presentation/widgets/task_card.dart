import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/routes/app_route.dart';
import '../../core/config/theme/colors.dart';
import '../../core/utils/context_helper.dart';
import '../../domain/entities/task_entity.dart';
import '../bloc/tasks/tasks_bloc.dart';
import '../bloc/tasks/tasks_event.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final TaskEntity task;

  void _navigateToTaskExecution(BuildContext context, TaskEntity task) {
    context.push(Routes.taskExecution.path, extra: task.id);
    context.read<TasksBloc>().add(LoadTasks());
  }

  Widget _buildDismissBackground() {
    return Container(
      color: colorError,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.delete, color: colorBackgroundWhite),
        ),
      ),
    );
  }

  Future<bool> _onDismiss(BuildContext context, TaskEntity task) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Excluir Tarefa'),
            content: const Text('Deseja realmente excluir a tarefa?'),
            actions: [
              TextButton(
                onPressed: () => context.pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => context.pop(true),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );

    if (result == true && context.mounted) {
      context.read<TasksBloc>().add(DeleteTask(taskId: task.id));
    }

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Dismissible(
          key: Key(task.id.toString()),
          background: _buildDismissBackground(),
          confirmDismiss: (direction) async => _onDismiss(context, task),
          direction: DismissDirection.endToStart,
          child: ListTile(
            leading: Icon(
              task.isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: task.isCompleted ? colorSuccess : colorGrey,
            ),
            title: Text(task.taskName, style: context.textTheme.titleMedium),
            subtitle: Text(task.description),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () => _navigateToTaskExecution(context, task),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
