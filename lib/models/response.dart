import 'package:hive_flutter/hive_flutter.dart';
import '../models/survey.dart';
import '../models/question.dart';

class HiveService {
  static const String surveysBoxName = 'surveys';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(SurveyAdapter());
    Hive.registerAdapter(QuestionAdapter());
    Hive.registerAdapter(QuestionTypeAdapter());

    await Hive.openBox<Survey>(surveysBoxName);
  }

  static Box<Survey> getSurveysBox() {
    return Hive.box<Survey>(surveysBoxName);
  }

  static Future<void> saveSurvey(Survey survey) async {
    final box = getSurveysBox();
    await box.put(survey.id, survey);
  }

  static Future<Survey?> getSurvey(String id) async {
    final box = getSurveysBox();
    return box.get(id);
  }

  static Future<List<Survey>> getAllSurveys() async {
    final box = getSurveysBox();
    return box.values.toList();
  }
}
