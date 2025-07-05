import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mynotewriter/services/hive_services/hive_app_service.dart';

import '../../models/feedback_model.dart';
import '../../widgets/custom_snackbar.dart';

class SpringBootFeedbackService {
  Future<bool> saveFeedback(
    BuildContext context,
    bool isDark,
    FeedbackModel feedbackModel,
  ) async {
    try {
      final url = Uri.parse(
        "https://springbootserver-production.up.railway.app/api/v1/feedback/save",
      );

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': 'FLUTTER_APP_KEY_2e81df3a-b618-4dc4-8571-f5b72d4cc2d9',
        },
        body: jsonEncode({
          "id": feedbackModel.id,
          "sendAt": feedbackModel.sendAt.toIso8601String(),
          "feedback": feedbackModel.feedback,
        }),
      );

      if (response.statusCode != 200) {
        HiveAppService().storeFeedbacks(feedback: feedbackModel);
        // if (context.mounted) {
        //   customSnackBarWidget(
        //     context: context,
        //     title: "Unable to sent feedback",
        //     isDark: isDark,
        //     isError: true,
        //   );
        // }
        // print(
        //   "❌ Error ${response.statusCode}: ${response.body} ---> ${response.headers}",
        // );
        // return true;
      }

      // await Future.delayed(Duration(seconds: 3));
      // print("✅ Success: ${response.body}");
      if (context.mounted) {
        customSnackBarWidget(
          context: context,
          title: "feedback sent successful",
          isDark: isDark,
        );
      }
      return true;
    } catch (err) {
      await Future.delayed(Duration(seconds: 1));

      // if (context.mounted) {
      //   customSnackBarWidget(
      //     context: context,
      //     title: "Unable to sent feedback chek you connection",
      //     isDark: isDark,
      //     isError: true,
      //   );
      // }
      // print("############## saveFeedback err $err");
      HiveAppService().storeFeedbacks(feedback: feedbackModel);

      return true;
    }
  }

  Future<bool> savePendingFeedbacks(FeedbackModel feedback) async {
    try {
      final url = Uri.parse(
        "https://springbootserver-production.up.railway.app/api/v1/feedback/save",
      );

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': 'FLUTTER_APP_KEY_2e81df3a-b618-4dc4-8571-f5b72d4cc2d9',
        },
        body: jsonEncode({
          "id": feedback.id,
          "sendAt": feedback.sendAt.toIso8601String(),
          "feedback": feedback.feedback,
        }),
      );

      if (response.statusCode == 200) return true;

      return false;
    } catch (_) {
      return false;
    }
  }
}
