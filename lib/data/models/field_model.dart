import '../../domain/entities/field_entity.dart';

class FieldModel extends FieldEntity {
  const FieldModel({
    required super.id,
    required super.label,
    required super.req,
    required super.fieldType,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      id: json['id'] as int,
      label: json['label'] as String,
      req: json['required'] as bool,
      fieldType: json['field_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'required': req,
      'field_type': fieldType,
    };
  }
}
