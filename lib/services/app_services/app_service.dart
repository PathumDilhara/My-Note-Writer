import 'package:package_info_plus/package_info_plus.dart';

import '../hive_services/hive_user_service.dart';

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

  Future<bool> isUpdatesPostponed() async{
    try {
      DateTime dateTime = await HiveUserService().getPostponedDate();

      int postponedDate = int.parse(
          dateTime.toString().split(" ")[0].split("-").join(""))+2;

      int today = int.parse(
          DateTime.now().toString().split(" ")[0].split("-").join(""));

      // print("################AppServices postponedDate $postponedDate today $today");

      return postponedDate >= today;
    } catch (_) {
      return false;
    }

  }
}
