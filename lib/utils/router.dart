import 'package:go_router/go_router.dart';

import '../models/note_model.dart';
import '../screens/contact_us_screen.dart';
import '../screens/create_new_note_screen.dart';
import '../screens/help_screen.dart';
import '../screens/note_viewer_screen.dart';
import '../screens/home_screen.dart';
import '../screens/privacy_policy_screen.dart';
import 'app_router_paths.dart';

class GoRouterClass {
  static final router = GoRouter(
    initialLocation: "/${AppRouterPaths.homeScreen}",
    routes: [
      // Home Screen
      GoRoute(
        name: AppRouterPaths.homeScreen,
        path: "/${AppRouterPaths.homeScreen}",
        builder: (context, state) => HomeScreen(),
      ),

      // Single note viewing screen
      GoRoute(
        name: "/${AppRouterPaths.noteViewScreen}",
        path: "/${AppRouterPaths.noteViewScreen}",
        builder: (context, state) {
          final note = state.extra as NoteModel;
          return NoteViewerScreen(noteModel: note);
        },
      ),

      // Settings Screen
      GoRoute(
        name: AppRouterPaths.privacyPolicyScreen,
        path: "/${AppRouterPaths.privacyPolicyScreen}",
        builder: (context, state) => PrivacyPolicyScreen(),
      ),

      // Contact Us Screen
      GoRoute(
        name: AppRouterPaths.contactUsScreen,
        path: "/${AppRouterPaths.contactUsScreen}",
        builder: (context, state) => ContactUsScreen(),
      ),

      // Help Screen
      GoRoute(
        name: AppRouterPaths.helpScreen,
        path: "/${AppRouterPaths.helpScreen}",
        builder: (context, state) => HelpScreen(),
      ),

      // Home Screen
      GoRoute(
        name: AppRouterPaths.createNewNoteScreen,
        path: "/${AppRouterPaths.createNewNoteScreen}",
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          final note = data?['note'] as NoteModel?;
          final purpose = data?['mode'] as String? ?? 'create';
          return CreateNewNoteScreen(noteModel: note, purpose: purpose);
        },
      ),
    ],
  );
}
