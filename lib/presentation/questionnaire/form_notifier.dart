import 'package:finmapp_assignment/di/inject.dart';
import 'package:finmapp_assignment/domain/core/value_objects.dart';
import 'package:finmapp_assignment/domain/questionnaire/option.dart';
import 'package:finmapp_assignment/infra/questionnaire/i_questionnaire_repo.dart';
import 'package:finmapp_assignment/presentation/core/viewstate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import 'form_state.dart';

final formProvider = StateNotifierProvider<FormNotifier, FormState>((ref) => getIt<FormNotifier>()..loadFormData());

@injectable
class FormNotifier extends StateNotifier<FormState> {
  final IQuestionnaireRepo _repo;

  FormNotifier(this._repo)
      : super(FormState(ViewState.loading, 0, <UniqueId, FormSection>{}));

  Future<void> loadFormData() async {
    state = state.copyWith(state: ViewState.loading);
    final questionnaire = await _repo.fetchQuestionnaire();

    final fields = questionnaire.schema.fields;

    for (int i = 0; i < fields.length; i++) {
      fields[i].when(
        section: (_, __, schema) =>
            state.sections[UniqueId.fromUniqueString("${fields[i].type}$i")] =
                FormSection(
                    Map.fromIterable(schema.fields!,
                        key: (field) =>
                            UniqueId.fromUniqueString(field.schema.name),
                        value: (field) => field),
                    UniqueId.fromUniqueString(schema.name)),
        label: (_, __, schema) {
          state.sections[UniqueId.fromUniqueString("${fields[i].type}$i")] =
              FormSection({UniqueId.fromUniqueString(schema.name): fields[i]},
                  UniqueId.fromUniqueString(schema.name));
        },
        numeric: (_, __, schema) {
          state.sections[UniqueId.fromUniqueString("${fields[i].type}$i")] =
              FormSection({UniqueId.fromUniqueString(schema.name): fields[i]},
                  UniqueId.fromUniqueString(schema.name));
        },
        singleChoiceSelector: (_, __, schema) {
          state.sections[UniqueId.fromUniqueString("${fields[i].type}$i")] =
              FormSection({UniqueId.fromUniqueString(schema.name): fields[i]},
                  UniqueId.fromUniqueString(schema.name));
        },
        singleSelect: (_, __, schema) {
          state.sections[UniqueId.fromUniqueString("${fields[i].type}$i")] =
              FormSection({UniqueId.fromUniqueString(schema.name): fields[i]},
                  UniqueId.fromUniqueString(schema.name));
        },
      );

      state = state.copyWith(state: ViewState.idle);
    }
  }

  addOrUpdateField(String sectionId, String fieldId, [Option? value]) {
    var section = state.sections[UniqueId.fromUniqueString(sectionId)];
    var field = section?.fields[UniqueId.fromUniqueString(fieldId)];
    field?.maybeMap(
        orElse: () {},
        singleSelect: (field) {
          section?.fields[UniqueId.fromUniqueString(fieldId)] =
              field.copyWith.schema(value: value);
        },
        label: (field) {
          section?.fields[UniqueId.fromUniqueString(fieldId)] =
              field.copyWith.schema(value: value);
        },
        numeric: (field) {
          section?.fields[UniqueId.fromUniqueString(fieldId)] =
              field.copyWith.schema(value: value);
        },
        singleChoiceSelector: (field) {
          section?.fields[UniqueId.fromUniqueString(fieldId)] =
              field.copyWith.schema(value: value);
        });
    state = state;
  }

  next() {
    state = state.copyWith(cursor: state.cursor + 1);
  }

  prev() {
    if (state.cursor > 0) {
      state = state.copyWith(cursor: state.cursor - 1);
    }
  }
}
