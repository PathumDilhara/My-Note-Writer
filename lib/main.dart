import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'models/note_model.dart';
import 'services/provider_services/note_service_provider.dart';
import 'utils/custom_theme.dart';
import 'utils/router.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox("notesBox");
  await Hive.openBox("appDataBox");

  FlutterNativeSplash.remove();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteServiceProvider(),
      child: MyApp(),
    ),
  );
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

// dart run flutter_native_splash:create --path=flutter_native_splash.yaml
// dart run flutter_native_splash:create --path=flutter_native_splash.yaml