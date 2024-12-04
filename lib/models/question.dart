import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 1)
enum QuestionType {
  @HiveField(0)
  text,
  @HiveField(1)
  multipleChoice,
  @HiveField(2)
  number,
  @HiveField(3)
  date
}

@HiveType(typeId: 0)
class Question extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final QuestionType type;

  @HiveField(3)
  final List<String>? options;

  @HiveField(4)
  final bool isRequired;

  Question({
    required this.id,
    required this.text,
    required this.type,
    this.options,
    this.isRequired = true,
  });
}
