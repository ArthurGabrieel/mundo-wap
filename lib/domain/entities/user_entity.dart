import 'package:equatable/equatable.dart';

import 'task_entity.dart';

class UserEntity extends Equatable {
  final String name;
  final String profile;
  final List<TaskEntity> tasks;

  const UserEntity({
    required this.name,
    required this.profile,
    required this.tasks,
  });

  @override
  List<Object?> get props => [name, profile, tasks];
}
