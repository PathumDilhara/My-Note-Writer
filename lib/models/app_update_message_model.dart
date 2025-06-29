import 'package:json_annotation/json_annotation.dart';

part 'app_update_message_model.g.dart';

@JsonSerializable()
class AppUpdateMessageModel {
  final int? id;
  final String updateTitle;
  final String updateDescription;
  final String updateUrl;
  final String newVersion;
  final bool canIgnore;

  AppUpdateMessageModel({
    required this.id,
    required this.updateTitle,
    required this.updateDescription,
    required this.updateUrl,
    required this.newVersion,
    required this.canIgnore,
  });

  factory AppUpdateMessageModel.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppUpdateMessageModelToJson(this);
}

// // Deserialize
// final json = {'name': 'Pathum', 'age': 22};
// final user = User.fromJson(json);
//
// // Serialize
// print(user.toJson()); // {name: Pathum, age: 22}
