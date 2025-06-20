import 'package:flutter/material.dart';

import 'utils/custom_theme.dart';
import 'utils/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "MyNoteWriter",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouterClass.router,
      // home: HomePage(),
    );
  }
}
