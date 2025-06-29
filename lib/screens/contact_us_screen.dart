import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/colors.dart';
import '../widgets/custom_snackbar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  final String email = "somalathaweerakoon1978@gmail.com";

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Contact Us"),
            SizedBox(width: 10),
            Icon(Icons.contacts_outlined, size: 25),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "💬 We'd love to hear from you!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    isDark
                        ? AppColors.primWhiteColor
                        : AppColors.primBlackColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "If you're facing issues or have suggestions to improve the app, feel free to reach out.",
              style: TextStyle(fontSize: 16, color: AppColors.primGreyColor),
            ),
            const SizedBox(height: 30),

            // Button mailto
            ElevatedButton.icon(
              onPressed: () async {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: email,
                  queryParameters: {
                    'subject': 'Support Request',
                    'body': 'Hello,',
                  },
                );

                try {
                  if (await canLaunchUrl(emailUri)) {
                    await launchUrl(
                      emailUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    // Handle the case when the email app is not available
                    if (context.mounted) {
                      customSnackBarWidget(
                        context: context,
                        title: "No email app found!",
                        isDark: isDark,
                        isError: true,
                      );
                    }
                  }
                } catch (err) {
                  if (context.mounted) {
                    customSnackBarWidget(
                      context: context,
                      title: "Something went wrong!",
                      isDark: isDark,
                      isError: true,
                    );
                  }
                }
              },
              icon: Icon(
                Icons.mail_outline_outlined,
                color: AppColors.primWhiteColor,
              ),
              label: Text("Send Email to Support"),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDark
                        ? AppColors.primButtonBGColorDark
                        : AppColors.primButtonBGColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
