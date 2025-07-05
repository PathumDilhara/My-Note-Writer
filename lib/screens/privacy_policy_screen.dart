import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:http/http.dart' as http;

import '../utils/colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  // TODO : replace with exact one
  final String _privacyPolicyUrl =
      "huoihhttps://raw.githubusercontent.com/Somalatha-Weerakoon/Status-Verse-privacy-Policy/refs/heads/main/privacy_policy.md";

  Future<String> fetchPrivacyPolicy() async {
    final response = await http.get(Uri.parse(_privacyPolicyUrl));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load privacy policy');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Privacy Policy"),
            SizedBox(width: 10),
            Icon(Icons.privacy_tip_outlined, size: 25),
          ],
        ),
      ),
      body: FutureBuilder(
        future: fetchPrivacyPolicy(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primButtonBGColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primButtonBGColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Scrollbar(
                thickness: 6,
                radius: Radius.circular(100),
                child: Markdown(data: snapshot.data ?? ''),
              ),
            );
          }
        },
      ),
    );
  }
}
