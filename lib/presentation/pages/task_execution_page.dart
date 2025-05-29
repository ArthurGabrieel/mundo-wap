import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/theme/colors.dart';
import '../../core/utils/context_helper.dart';
import '../../domain/entities/field_entity.dart';
import '../../domain/entities/task_entity.dart';
import '../bloc/task_execution/task_execution_bloc.dart';
import '../bloc/task_execution/task_execution_event.dart';
import '../bloc/task_execution/task_execution_state.dart';
import '../bloc/tasks/tasks_bloc.dart';
import '../bloc/tasks/tasks_event.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/failure_widget.dart';
import '../widgets/task_form_field.dart';

class TaskExecutionPage extends StatefulWidget {
  final int taskId;

  const TaskExecutionPage({required this.taskId, super.key});

  @override
  State<TaskExecutionPage> createState() => _TaskExecutionPageState();
}

class _TaskExecutionPageState extends State<TaskExecutionPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    context.read<TaskExecutionBloc>().add(
      LoadTaskDetails(taskId: widget.taskId),
    );
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final formData = <String, dynamic>{};
      _controllers.forEach((label, controller) {
        formData[label] = controller.text;
      });

      context.read<TaskExecutionBloc>().add(
        SaveTaskExecution(taskId: widget.taskId, formData: formData),
      );
    }
  }

  void _syncControllers(
    List<FieldEntity> fields,
    Map<String, dynamic> formValues,
  ) {
    for (var field in fields) {
      final value = formValues[field.label]?.toString() ?? '';

      final controller = _controllers.putIfAbsent(
        field.label,
        () => TextEditingController(),
      );

      if (controller.text != value) {
        controller.text = value;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Executar Tarefa'),
      body: BlocConsumer<TaskExecutionBloc, TaskExecutionState>(
        listener: (context, state) {
          if (state is TaskExecutionSaveSuccess) {
            context.showSnackBar(
              'Tarefa salva com sucesso!',
              color: colorSuccess,
            );
            context.pop();
            context.read<TasksBloc>().add(LoadTasks());
          } else if (state is TaskExecutionSaveFailure) {
            context.showSnackBar('Erro ao salvar: ${state.message}');
          }
        },
        builder: (context, state) {
          if (state is TaskExecutionLoading || state is TaskExecutionInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskExecutionLoadSuccess ||
              state is TaskExecutionSaveFailure) {
            final TaskEntity task;
            final Map<String, dynamic> formValues;

            if (state is TaskExecutionLoadSuccess) {
              task = state.task;
              formValues = state.formValues;
            } else {
              task = (state as TaskExecutionSaveFailure).task;
              formValues = state.formValues;
            }

            _syncControllers(task.fields, formValues);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TaskHeader(task: task),
                    const SizedBox(height: 24),
                    TaskFormFieldsWidget(
                      taskId: widget.taskId,
                      fields: task.fields,
                      controllers: _controllers,
                    ),
                    const SizedBox(height: 24),
                    _TaskSubmissionSection(
                      currentState: state,
                      onSubmit: _submitForm,
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is TaskExecutionLoadFailure) {
            return Center(
              child: FailureWidget(
                message: 'Erro ao carregar dados da tarefa: ${state.message}',
                onRetry:
                    () => context.read<TaskExecutionBloc>().add(
                      LoadTaskDetails(taskId: widget.taskId),
                    ),
              ),
            );
          }

          return const Center(child: Text('Estado inesperado ou não tratado.'));
        },
      ),
    );
  }
}

class _TaskHeader extends StatelessWidget {
  final TaskEntity task;

  const _TaskHeader({required this.task});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(task.taskName, style: context.textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(task.description),
      ],
    );
  }
}

class _TaskSubmissionSection extends StatelessWidget {
  final TaskExecutionState currentState;
  final VoidCallback onSubmit;

  const _TaskSubmissionSection({
    required this.currentState,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    if (currentState is TaskExecutionLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: onSubmit,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('Executar Tarefa'),
        ),
        if (currentState is TaskExecutionSaveFailure)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              'Erro ao executar, tente novamente.',
              style: context.textTheme.labelSmall?.copyWith(color: colorError),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
