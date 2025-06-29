import 'package:hive/hive.dart';

class HiveUserService {
  // Database reference
  final _appDataBox = Hive.box("appDataBox");

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

  Future<void> storePostponedDate(DateTime dateTime) async {
    // print("*********HiveUserService store postponed_date $dateTime");
    try {
      _appDataBox.put("postponed_date", dateTime);
    } catch (_) {}
  }
}
