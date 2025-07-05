import 'package:mynotewriter/models/feedback_model.dart';
import 'package:mynotewriter/services/spring_boot_services/spring_boot_feedback_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../hive_services/hive_app_service.dart';

class AppServices {
  Future<String> getAppCurrentVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // print("############## ${packageInfo.version}");
      return packageInfo.version;
    } catch (err) {
      // print("%%%%%%%%%%%%%%%%%%%%%% getAppVersion $err");
      // throw Exception("wait...");
      return "1.0.0";
    }
  }

  Future<bool> isVersionOutdated({
    required String newVersion,
    required String currentVersion,
  }) async {
    List<int> current = currentVersion.split(".").map(int.parse).toList();
    List<int> newVer = newVersion.split(".").map(int.parse).toList();
    // print("%%%%%%%%%%%%% $current $newVer");
    for (int i = 0; i < current.length; i++) {
      if (newVer[i] > current[i]) return true;
      if (newVer[i] < current[i]) return false;
    }
    return false;
  }

  Future<bool> isUpdatesPostponed() async {
    try {
      DateTime dateTime = await HiveAppService().getPostponedDate();

      int postponedDate =
          int.parse(dateTime.toString().split(" ")[0].split("-").join("")) + 2;

      int today = int.parse(
        DateTime.now().toString().split(" ")[0].split("-").join(""),
      );

      // print("################AppServices postponedDate $postponedDate today $today");

      return postponedDate >= today;
    } catch (_) {
      return false;
    }
  }
}

Future<void> pendingFeedbackSender() async {
  final HiveAppService hiveAppService = HiveAppService();
  final SpringBootFeedbackService springBootFeedbackService =
      SpringBootFeedbackService();

  final feedbackToRemove = [];
  List<FeedbackModel> feedbacks = await hiveAppService.getPendingFeedbacks();
  // print("############ ${feedbacks.length}");

  for (var feedback in feedbacks) {
    bool isSend = await springBootFeedbackService.savePendingFeedbacks(
      feedback,
    );
    if (isSend) {
      // print("############## pending feedback sent");
      feedbackToRemove.add(feedback);
    }
  }

  if (feedbackToRemove.isNotEmpty) {
    List<FeedbackModel> results =
        feedbacks.where((item) => !feedbackToRemove.contains(item)).toList();
    hiveAppService.saveFeedbackList(results);
  }
}
