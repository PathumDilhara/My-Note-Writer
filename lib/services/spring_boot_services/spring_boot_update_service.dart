import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/app_update_message_model.dart';

class SpringBootUpdateService {
  Future<AppUpdateMessageModel?> getUpdateMessage() async {
    // print("##############");
    try {
      final url = Uri.parse(
        "https://springbootserver-production.up.railway.app/api/v1/appUpdate/123",
      );
      final response = await http.get(url);

      // print("##############isEmpty ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return AppUpdateMessageModel.fromJson(jsonData);
      } else {
        // print("############## err");
        return null;
      }

      // ##############
      // final updateJson = {
      //   "id": "update_001",
      //   "updateTitle": "New Features in v2.0.0",
      //   "updateDescription": "We've added dark mode, fixed bugs, and improved performance.",
      //   "updateUrl": "https://yourapp.com/update",
      //   "newVersion": "2.0.0",
      //   "canIgnore": true
      // };
      //
      // final updateMessage = AppUpdateMessageModel.fromJson(updateJson);
      // return updateMessage;
    } catch (_) {
      return null;
    }
  }
}
