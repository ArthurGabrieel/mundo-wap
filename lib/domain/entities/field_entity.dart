import 'package:equatable/equatable.dart';

class FieldEntity extends Equatable {
  final int id;
  final String label;
  final bool req;
  final String fieldType;

  const FieldEntity({
    required this.id,
    required this.label,
    required this.req,
    required this.fieldType,
  });

  @override
  List<Object?> get props => [id, label, req, fieldType];
}
