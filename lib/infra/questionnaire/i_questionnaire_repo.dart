import 'package:finmapp_assignment/domain/questionnaire/questionnaire.dart';

abstract class IQuestionnaireRepo {
  Future<Questionnaire> fetchQuestionnaire();
}