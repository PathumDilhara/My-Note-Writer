import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/feedback_model.dart';
import '../services/spring_boot_services/spring_boot_feedback_service.dart';
import '../utils/app_router_paths.dart';
import '../utils/colors.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // bool isFeedbackSending = false;
  ValueNotifier<bool> isFeedbackSending = ValueNotifier<bool>(false);

  @override
  void dispose() {
    super.dispose();
    _feedbackController.dispose();
  }

  void sendFeedback(bool isDark) async {
    // print("############### Sending");
    if (_formKey.currentState!.validate()) {
      isFeedbackSending.value = true;
      // print("################# valid");

      final FeedbackModel feedbackModel = FeedbackModel(
        sendAt: DateTime.now(),
        feedback: _feedbackController.text,
      );

      bool isFeedbackSent = await SpringBootFeedbackService().saveFeedback(
        context,
        isDark,
        feedbackModel,
      );

      // print("########################");
      if (mounted && isFeedbackSent) {
        GoRouter.of(
          context,
        ).pushReplacement("/${AppRouterPaths.contactUsScreen}");
      }
      isFeedbackSending.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final borderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primGreyColor),
      borderRadius: BorderRadius.circular(10),
    );
    return Scaffold(
      appBar: AppBar(title: Text("Feedback")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Center(
                child: Text(
                  "We value your opinion!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Do you have any thoughts you'd like to share?",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 20),

              // User feedback input
              TextFormField(
                controller: _feedbackController,
                decoration: InputDecoration(
                  hintText: "Share your thoughts here...",
                  hintStyle: TextStyle(
                    color: AppColors.primGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primGreyColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: borderStyle,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primButtonBGColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: borderStyle,
                ),
                maxLines: 5,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your feedback.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton(
                    isDark: isDark,
                    onPressed: () {
                      return sendFeedback(isDark);
                    },
                    title: "Send",
                    bgColor: AppColors.primButtonBGColor,
                    overlayColor: Colors.blueAccent,
                  ),
                  _buildButton(
                    isDark: isDark,
                    onPressed: () {},
                    title: "cancel",
                    bgColor: Colors.grey.shade300,
                    overlayColor: Colors.grey.shade400,
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: isFeedbackSending,
                builder: (context, value, child) {
                  return value
                      ? Dialog(
                        child: Container(
                          // height: 50,
                          // width: 50,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(color: Colors.transparent),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: AppColors.primButtonBGColor,
                            strokeWidth: 3,
                          ),
                        ),
                      )
                      : SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required String title,
    required bool isDark,
    required Color bgColor,
    required Color overlayColor,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(bgColor),
        foregroundColor: WidgetStatePropertyAll(
          isDark ? AppColors.primWhiteColor : AppColors.primBlackColor,
        ),
        overlayColor: WidgetStatePropertyAll(overlayColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        // maximumSize: WidgetStatePropertyAll(Size(100, 100)),
        minimumSize: WidgetStatePropertyAll(
          Size(MediaQuery.of(context).size.width * 0.4, 50),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
