import 'dart:convert';

import 'package:finmapp_assignment/domain/questionnaire/questionnaire.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import 'i_questionnaire_repo.dart';

@LazySingleton(as: IQuestionnaireRepo)
class LocalQuestionnaireRepo implements IQuestionnaireRepo {

  @override
  Future<Questionnaire> fetchQuestionnaire() async {
    final data = await rootBundle.loadString('assets/questions.json');
    return Questionnaire.fromJson(json.decode(data));
  }

}