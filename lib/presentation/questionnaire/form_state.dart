import 'package:finmapp_assignment/domain/core/value_objects.dart';
import 'package:finmapp_assignment/domain/questionnaire/field.dart';
import 'package:finmapp_assignment/presentation/core/viewstate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_state.freezed.dart';

@freezed
class FormState with _$FormState {
  const factory FormState(ViewState state, int cursor, Map<UniqueId, FormSection> sections) =
      _FormState;
}

@freezed
class FormSection with _$FormSection {
  const factory FormSection(Map<UniqueId, Field> fields, UniqueId id) = _FormSection;
}
