import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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
        "https://springbootserver-production.up.railway.app/api/v1/feedback/saveFeedback",
      );

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "id": feedbackModel.id,
          "sendAt": feedbackModel.sendAt,
          "feedback": feedbackModel.feedback,
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Success: ${response.body}");
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
      }

      // await Future.delayed(Duration(seconds: 3));

      if (context.mounted) {
        customSnackBarWidget(
          context: context,
          title: "feedback sent successful",
          isDark: isDark,
        );
      }
      return true;
      // return null;
    } catch (err) {
      await Future.delayed(Duration(seconds: 1));

      if (context.mounted) {
        customSnackBarWidget(
          context: context,
          title: "Unable to sent feedback chek you connection",
          isDark: isDark,
          isError: true,
        );
      }
      print("############## saveFeedback err $err");

      return false;
      // return null;
    }
  }
}
