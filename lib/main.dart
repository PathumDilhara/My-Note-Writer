import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/note_model.dart';
import 'utils/custom_theme.dart';
import 'utils/router.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox("notesBox");

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
