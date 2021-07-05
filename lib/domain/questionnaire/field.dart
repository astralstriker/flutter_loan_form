import 'package:freezed_annotation/freezed_annotation.dart';

import 'option.dart';

part 'field.freezed.dart';
part 'field.g.dart';


@Freezed(unionKey: "type", unionValueCase: FreezedUnionCase.pascal)
class Field with _$Field {
  const factory Field.singleChoiceSelector({
    required String type,
    required int version,
    required FieldSchema schema,
  }) = SingleChoiceSelector;

  const factory Field.singleSelect({
    required String type,
    required int version,
    required FieldSchema schema,
  }) = SingleSelect;

  const factory Field.numeric({
    required String type,
    required int version,
    required FieldSchema schema,
  }) = Numeric;

  const factory Field.label({
    required String type,
    required int version,
    required FieldSchema schema,
  }) = Label;

  const factory Field.section({
    required String type,
    required int version,
    required SectionSchema schema,
  }) = Section;

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);
}

@freezed
class SectionSchema with _$SectionSchema {
 const factory SectionSchema({
    required String name,
    required String label,
    List<Field>? fields,
  }) = _SectionSchema;

  factory SectionSchema.fromJson(Map<String, dynamic> json) =>
      _$SectionSchemaFromJson(json);
}

@freezed
class FieldSchema with _$FieldSchema {
  const factory FieldSchema({
    required String name,
    required String label,
    Option? value,
    @Default(false) dynamic hidden,
    bool? readonly,
    List<Option>? options,
  }) = _FieldSchema;

  factory FieldSchema.fromJson(Map<String, dynamic> json) =>
      _$FieldSchemaFromJson(json);
}
