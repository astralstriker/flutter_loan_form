import 'package:finmapp_assignment/domain/core/value_objects.dart';
import 'package:finmapp_assignment/domain/questionnaire/option.dart';
import 'package:finmapp_assignment/presentation/questionnaire/form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomRadioField extends StatelessWidget {
  final String sectionId;
  final String id;
  final String? value;
  final List<Option> options;

  CustomRadioField(this.id, this.value, this.options, this.sectionId);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options
          .map((e) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Radio<String>(
                      groupValue: value,
                      value: e.value,
                      key: ValueKey(e.key),
                      onChanged: (v) {
                        if (v != null) {
                          context.read(formProvider.notifier).addOrUpdateField(
                              sectionId, id, e.copyWith(value: v));
                        }
                      },
                    ),
                  ),
                  Text(e.value),
                ],
              ))
          .toList(),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String sectionId;
  final String id;
  final String? value;
  final List<Option> options;

  CustomDropdown(this.id, this.value, this.options, this.sectionId);
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: value ?? sectionId,
        items: [...options, Option(key: UniqueId(), value: sectionId)]
            .map((e) => DropdownMenuItem(
                  key: ValueKey(e.key),
                  child: Text(e.value),
                  value: e.value,
                ))
            .toList());
  }
}
