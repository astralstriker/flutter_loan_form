import 'package:finmapp_assignment/domain/core/value_objects.dart';
import 'package:finmapp_assignment/domain/questionnaire/field.dart';
import 'package:finmapp_assignment/presentation/core/viewstate.dart';
import 'package:finmapp_assignment/presentation/questionnaire/form_notifier.dart';
import 'package:finmapp_assignment/presentation/questionnaire/form_state.dart';
import 'package:finmapp_assignment/presentation/questionnaire/form_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Questionnaire extends HookWidget {
  const Questionnaire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = useProvider(formProvider);
    final controller = usePageController();
    return Scaffold(
      body: notifier.state == ViewState.loading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: controller,
                      physics: NeverScrollableScrollPhysics(),
                      children: notifier.sections.entries
                          .map((e) => SectionWidget(
                                e.key,
                                e.value,
                                key: PageStorageKey(e.key),
                              ))
                          .toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            context.read(formProvider.notifier).prev();
                            controller.jumpToPage(notifier.cursor);
                          },
                          child: Text('Prev')),
                      ElevatedButton(
                          onPressed: () {
                            if (notifier.cursor <
                                notifier.sections.length - 1) {
                              context.read(formProvider.notifier).next();
                            }
                            controller.jumpToPage(notifier.cursor);
                          },
                          child: Text('Next')),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

class SectionWidget extends ConsumerWidget {
  final UniqueId id;
  final FormSection section;
  const SectionWidget(this.id, this.section, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final notifier = watch(formProvider);
    return Column(
      children: section.fields.entries
          .map((e) => FieldWidget(e.key, e.value, id))
          .toList(),
    );
  }
}

class FieldWidget extends ConsumerWidget {
  final UniqueId id;
  final UniqueId sectionId;
  final Field field;

  FieldWidget(this.id, this.field, this.sectionId);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final notifier = watch(formProvider);
    return field.maybeMap(
      orElse: () => ListTile(
        title: Text(field.type),
      ),
      singleChoiceSelector: (singleChoiceSelector) => CustomRadioField(
        singleChoiceSelector.schema.name,
        singleChoiceSelector.schema.value?.value,
        singleChoiceSelector.schema.options ?? [],
        sectionId.getOrCrash(),
      ),
      singleSelect: (singleSelect) => CustomDropdown(
        singleSelect.schema.name,
        singleSelect.schema.value?.value,
        singleSelect.schema.options ?? [],
        sectionId.getOrCrash(),
      ),
    );
  }
}
