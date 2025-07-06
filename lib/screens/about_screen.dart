import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mynotewriter/services/app_services/app_service.dart';
import 'package:mynotewriter/utils/app_router_paths.dart';
import 'package:mynotewriter/utils/colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

String _version = "loading...";

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
    getAppCurrentVersion();
  }

  void getAppCurrentVersion() async {
    String version = await AppServices().getAppCurrentVersion();
    setState(() {
      _version = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:  EdgeInsets.only(left: 5, top: MediaQuery.of(context).size.height*0.038),
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(
                        context,
                      ).pushReplacement("/${AppRouterPaths.homeScreen}");
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  isDark ? "assets/about dark.png" : "assets/about.png",
                  fit: BoxFit.fitWidth,
                  width: 100,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "MyNoteWriter",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "MyNoteWriter is a simple and offline-first note-taking app "
                  "that helps you write, store, and manage your thoughts easily. "
                  "All your notes are stored locally using Hive for better privacy "
                  "and faster access. Even if you're offline, your work is safe.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ),

              SizedBox(height: 20),
              Text(
                _version,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              SizedBox(height: 20),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 24.0),
              //   child: Text(
              //     "Developed by AppVibesSolutions",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: 14,
              //       fontStyle: FontStyle.italic,
              //       color: Colors.deepPurple,
              //     ),
              //   ),
              // ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      GoRouter.of(
                        context,
                      ).push("/${AppRouterPaths.contactUsScreen}");
                    },
                    child: Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            isDark
                                ? AppColors.primLightGreyColor
                                : AppColors.primBlackColor,
                      ),
                    ),
                  ),
                  Text(
                    " | ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          isDark
                              ? AppColors.primLightGreyColor
                              : AppColors.primBlackColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(
                        context,
                      ).push("/${AppRouterPaths.privacyPolicyScreen}");
                    },
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            isDark
                                ? AppColors.primLightGreyColor
                                : AppColors.primBlackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
