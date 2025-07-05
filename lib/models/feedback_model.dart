import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'feedback_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class FeedbackModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime sendAt;

  @HiveField(2)
  final String feedback;

  FeedbackModel({String? id, required this.sendAt, required this.feedback})
    : id = id ?? Uuid().v4();

  factory FeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackModelFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);
}
