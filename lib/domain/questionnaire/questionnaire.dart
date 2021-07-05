import 'package:freezed_annotation/freezed_annotation.dart';

import 'field.dart';

part 'questionnaire.freezed.dart';
part 'questionnaire.g.dart';

@freezed
class Questionnaire with _$Questionnaire {
  const factory Questionnaire({
    required String title,
    required String name,
    required String slug,
    required String description,
    required QuestionnaireSchema schema,
  }) = _Questionnaire;

  factory Questionnaire.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireFromJson(json);
}

@freezed
class QuestionnaireSchema with _$QuestionnaireSchema {
  const factory QuestionnaireSchema({
    required List<Field> fields,
  }) = _QuestionnaireSchema;

  factory QuestionnaireSchema.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireSchemaFromJson(json);
}
