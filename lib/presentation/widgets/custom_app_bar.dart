import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/routes/app_route.dart';
import '../../core/config/theme/colors.dart';
import '../bloc/task_execution/task_execution_bloc.dart';
import '../bloc/task_execution/task_execution_event.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.isHome = false});

  final String title;
  final bool? isHome;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: colorBlue3,
      actions: [
        if (isHome == true)
          IconButton(
            onPressed: () {
              context.read<TaskExecutionBloc>().add(EraseDrafts());
              context.go(Routes.login.path);
            },
            icon: const Icon(Icons.logout),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
