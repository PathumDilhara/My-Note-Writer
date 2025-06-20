import 'package:go_router/go_router.dart';
import 'package:mynotewriter/models/note_model.dart';
import 'package:mynotewriter/screens/contact_us_screen.dart';
import 'package:mynotewriter/screens/help_screen.dart';
import 'package:mynotewriter/screens/settings_screen.dart';

import '../screens/note_viewer_screen.dart';
import '../screens/home_screen.dart';
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
        name: AppRouterPaths.settingsScreen,
        path: "/${AppRouterPaths.settingsScreen}",
        builder: (context, state) => SettingsScreen(),
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
    ],
  );
}
