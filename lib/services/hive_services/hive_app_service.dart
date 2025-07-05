import 'package:hive/hive.dart';

import '../../models/feedback_model.dart';

class HiveAppService {
  // Database reference
  final _appDataBox = Hive.box("appDataBox");

  // Get app update postponed date
  Future<DateTime> getPostponedDate() async {
    try {
      final DateTime? postponedDate = await _appDataBox.get("postponed_date");
      // print("***********HiveUserService postponedDate $postponedDate");
      if (postponedDate == null) return DateTime(2000, 1, 1);
      // print("************HiveUserService return postponed_date $postponedDate");
      return postponedDate;
    } catch (err) {
      // print("###### HiveUserService err $err");
      return DateTime(2000, 1, 1);
    }
  }

  // Store app updated postponed date
  Future<void> storePostponedDate(DateTime dateTime) async {
    // print("*********HiveUserService store postponed_date $dateTime");
    try {
      _appDataBox.put("postponed_date", dateTime);
    } catch (_) {}
  }

  // Get feedbacks that saved as pending
  Future<List<FeedbackModel>> getPendingFeedbacks() async {
    try {
      List<FeedbackModel> pendingFeedbacks =
          await _appDataBox
              .get("pending_feedbacks")
              .cast<FeedbackModel>()
              .toList() ??
          [];
      return pendingFeedbacks;
    } catch (err) {
      // print("############### getPendingFeedbacks $err");
      return [];
    }
  }

  // Store sending failed feedbacks
  Future<void> storeFeedbacks({required FeedbackModel feedback}) async {
    // print("################ storing");
    try {
      List<FeedbackModel> pendingFeedbacks = await getPendingFeedbacks();
      pendingFeedbacks.add(feedback);

      await _appDataBox.put("pending_feedbacks", pendingFeedbacks);
      // print("################ storing suc");
    } catch (_) {
      // print("################ storing err $err");
    }
  }

  Future<void> saveFeedbackList(List<FeedbackModel> feedbacks) async {
    try {
      await _appDataBox.put("pending_feedbacks", feedbacks);
    } catch (_) {}
  }
}
