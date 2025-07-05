import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/app_update_message_model.dart';
import '../services/app_services/app_service.dart';
import '../services/provider_services/note_service_provider.dart';
import '../services/spring_boot_services/spring_boot_update_service.dart';
import '../utils/app_router_paths.dart';
import '../utils/colors.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/note_card_widget.dart';
import '../widgets/update_dialog_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NoteServiceProvider noteServiceProvider;
  final SpringBootUpdateService springBootUpdateService =
      SpringBootUpdateService();

  @override
  void initState() {
    super.initState();
    // _noteFetching();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call your provider method after the widget tree is built
      Provider.of<NoteServiceProvider>(
        context,
        listen: false,
      ).loadNotes(context: context);
    });
    BackButtonInterceptor.add(myInterceptor, name: "myInterceptorLiveStatus");

    updateDialogLoader();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    noteServiceProvider = Provider.of<NoteServiceProvider>(
      context,
      listen: false,
    );

    noteServiceProvider.createInitialNote();
  }

  final UpdateDialogBoxWidget _updateDialogBoxWidget = UpdateDialogBoxWidget();
  void updateDialogLoader() async {
    // print("############ updateDialogLoader");
    try {

      AppUpdateMessageModel? updateMessage =
          await springBootUpdateService.getUpdateMessage();

      final bool isUpdatePostponed = await AppServices().isUpdatesPostponed();

      final String currentVersion = await AppServices().getAppCurrentVersion();
      final bool isVersionOutsDated = await AppServices().isVersionOutdated(
        newVersion: updateMessage?.newVersion ?? "1.0.0",
        currentVersion: currentVersion,
      );

      // print(
      //   "############updateDialogLoader isUpdatePostponed  ${!isUpdatePostponed} isVersionOutsDated $isVersionOutsDated}",
      // );
      // print(
      //   "###################updateDialogLoader updateMessage ${updateMessage== null}",
      // );
      if (!isUpdatePostponed && isVersionOutsDated) {
        if (updateMessage != null && mounted) {
          _updateDialogBoxWidget.dialogBoxNormal(
            context: context,
            updateTitle: updateMessage.updateTitle,
            updateDescription: updateMessage.updateDescription,
            canIgnore: updateMessage.canIgnore,
          );
        }
      }
    } catch (_) {
      // print("############ updateDialogLoader err $err}");
    }
  }

  // Back button behavior handling
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (_updateDialogBoxWidget.isDialogOpen) {
      // Handle back button behavior here (e.g., dismiss dialog)
      return true; // Prevents default behavior
    }
    return false; // Allows default behavior
  }

  DateTime? _lastBackPressTime;

  Future<bool> _handleWillPop() async {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;

      customSnackBarWidget(
        context: context,
        title: "Tap again to exit",
        isDark: isDark,
      );
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    BackButtonInterceptor.removeByName("myInterceptorLiveStatus");
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result)async{
        if(didPop) return;
        final shouldPop = await _handleWillPop();
        if(shouldPop&& context.mounted){
          SystemNavigator.pop(); // This completely exits the app
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset("assets/logo_bg.png", fit: BoxFit.fitWidth),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: PopupMenuButton(
                color:
                    isDark
                        ? AppColors.primDarkScaffoldColor
                        : AppColors.primWhiteColor,
                menuPadding: EdgeInsets.zero,
                popUpAnimationStyle: AnimationStyle(
                  curve: Curves.decelerate,
                  reverseDuration: Duration(milliseconds: 200),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: "Help",
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.help_outline_rounded),
                          SizedBox(width: 10),
                          Text("Help"),
                        ],
                      ),
                    ),
      
                    PopupMenuItem(
                      value: "Privacy_Policy",
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.privacy_tip_outlined),
                          SizedBox(width: 10),
                          Text("Privacy Policy"),
                        ],
                      ),
                    ),
      
                    PopupMenuItem(
                      value: "Contact_Us",
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.contacts_outlined),
                          SizedBox(width: 10),
                          Text("Contact Us"),
                        ],
                      ),
                    ),
                  ];
                },
                padding: EdgeInsets.only(right: 50),
                onSelected: (value) {
                  if (value == "Privacy_Policy") {
                    GoRouter.of(
                      context,
                    ).push("/${AppRouterPaths.privacyPolicyScreen}");
                  } else if (value == "Help") {
                    GoRouter.of(context).push("/${AppRouterPaths.helpScreen}");
                  } else if (value == "Contact_Us") {
                    GoRouter.of(
                      context,
                    ).push("/${AppRouterPaths.contactUsScreen}");
                  }
                },
                child: Icon(Icons.more_vert, size: 30),
              ),
            ),
          ],
          title: Text(
            "MyNoteWriter",
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 40,
              fontFamily: GoogleFonts.birthstone().fontFamily,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push(
              "/${AppRouterPaths.createNewNoteScreen}",
              extra: {"mode": "create"},
            );
          },
          backgroundColor:
              isDark
                  ? AppColors.primButtonBGColorDark
                  : AppColors.primButtonBGColor,
          child: Icon(Icons.add, size: 30, color:isDark? AppColors.primWhiteColor :AppColors.primBlackColor),
        ),
        body: Consumer<NoteServiceProvider>(
          builder: (context, noteProvider, child) {
            if (noteProvider.notes.isEmpty) {
              return Center(
                child: Text(
                  "You haven't added any notes yet.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: StaggeredGrid.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        children:
                            noteProvider.notes
                                .map(
                                  (elt) => InkWell(
                                    onTap: () {
                                      GoRouter.of(context).push(
                                        "/${AppRouterPaths.noteViewScreen}",
                                        extra: elt.id,
                                      );
                                    },
                                    child: NoteCardWidget(noteModel: elt),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
