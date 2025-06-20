import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/note_model.dart';
import '../test_data.dart';
import '../utils/app_router_paths.dart';
import '../utils/colors.dart';
import '../widgets/note_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<NoteModel> notes = testNotes;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
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
          GoRouter.of(context).push("/${AppRouterPaths.createNewNoteScreen}");
        },
        backgroundColor:
            isDark
                ? AppColors.primButtonBGColorDark
                : AppColors.primButtonBGColor,
        child: Icon(Icons.add, size: 30, color: AppColors.primWhiteColor),
      ),
      body: Column(
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
                      notes
                          .map(
                            (elt) => InkWell(
                              onTap: () {
                                GoRouter.of(context).push(
                                  "/${AppRouterPaths.noteViewScreen}",
                                  extra: elt,
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
      ),
    );
  }
}
