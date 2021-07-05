import 'dart:convert';

import 'package:finmapp_assignment/domain/questionnaire/questionnaire.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart' show TestWidgetsFlutterBinding;
import 'package:test/test.dart';

void main() {
  test('questionnaire_test', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final value = await rootBundle.loadString('assets/questions.json');
    expect(value, (value) => value != null);
    final questionnaire = Questionnaire.fromJson(json.decode(value));
    expect(questionnaire, (q) => q != null);
    print(questionnaire.schema);
    print(questionnaire.schema.fields.map((e) => e.map(
        singleChoiceSelector: (q) => q.toString(),
        singleSelect: (q) => q.toString(),
        numeric: (q) => q.toString(),
        label: (q) => q.toString(),
        section: (q) => q.toString())));
  });
}
