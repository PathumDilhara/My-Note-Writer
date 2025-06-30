import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'feedback_model.g.dart';

@JsonSerializable()
class FeedbackModel {
  final String id;
  final DateTime sendAt;
  final String feedback;

  FeedbackModel({String? id, required this.sendAt, required this.feedback})
    : id = id ?? Uuid().v4();

  factory FeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackModelFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);

}
