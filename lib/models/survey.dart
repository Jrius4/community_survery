import 'package:hive/hive.dart';
import 'question.dart';

part 'survey.g.dart';

@HiveType(typeId: 2)
class Survey extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<Question> questions;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  DateTime? lastUpdated;

  @HiveField(6)
  Map<String, dynamic> responses;

  @HiveField(7)
  bool isCompleted;

  Survey({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.createdAt,
    this.lastUpdated,
    Map<String, dynamic>? responses,
    this.isCompleted = false,
  }) : responses = responses ?? {};
}
