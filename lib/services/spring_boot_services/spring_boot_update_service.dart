import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/app_update_message_model.dart';

class SpringBootUpdateService {
  Future<AppUpdateMessageModel?> getUpdateMessage() async {
    // print("##############");
    try {
      final url = Uri.parse(
        "https://springbootserver-production.up.railway.app/api/v1/appUpdate/getInfo/90235584-4330-4dfd-88e5-3408b4d7831d",
      );
      // 90235584-4330-4dfd-88e5-3408b4d7831d
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': 'FLUTTER_APP_KEY_2e81df3a-b618-4dc4-8571-f5b72d4cc2d9',
      });

      // print("##############isEmpty ${response.body}");

      if (response.statusCode == 200) {
        // print("############## success in update info fetching ${response.statusCode} ${response.body} ${response.headers}");
        final jsonData = jsonDecode(response.body);
        return AppUpdateMessageModel.fromJson(jsonData);
      } else {
        // print("############## error in update info fetching ${response.statusCode} ${response.body}");
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
