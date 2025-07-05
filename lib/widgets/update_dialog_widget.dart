import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/hive_services/hive_app_service.dart';
import '../utils/colors.dart';

class UpdateDialogBoxWidget {
  static final UpdateDialogBoxWidget _instance =
      UpdateDialogBoxWidget._internal();

  factory UpdateDialogBoxWidget() {
    return _instance;
  }

  UpdateDialogBoxWidget._internal();

  bool _isDialogOpen = false;

  bool get isDialogOpen => _isDialogOpen;

  void dialogBoxNormal({
    required BuildContext context,
    required String updateTitle,
    required String updateDescription,
    required String updateUrl,
    required bool canIgnore,
  }) {
    _isDialogOpen = !canIgnore;
    showDialog(
      context: context,
      barrierDismissible: canIgnore,
      builder: (context) {
        return AlertDialog(
          title: Text(
            updateTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: AppColors.primBlackColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Divider(color: AppColors.primLightGreyColor),
              ),
              Text(
                updateDescription,
                style: TextStyle(
                  // color: AppColors.primButtonBGColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          actions: <Widget>[
            if (canIgnore)
              TextButton(
                onPressed: () async {
                  HiveAppService().storePostponedDate(DateTime.now());
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "Not Now",
                  style: TextStyle(
                    color: AppColors.primLightGreyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            TextButton(
              onPressed: () async {
                // trying in app update
                try {
                  await InAppUpdate.performImmediateUpdate();
                } catch (_) {
                  try {
                    // if (await canLaunchUrl(Uri.parse(updateUrl))) {
                      await launchUrl(
                        Uri.parse(updateUrl),
                        mode: LaunchMode.externalApplication,
                      );
                    // }
                  } catch (_) {}
                } finally {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    _isDialogOpen = false;
                  }
                }
              },
              child: Text(
                "Update Now",
                style: TextStyle(
                  color: AppColors.primButtonBGColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
