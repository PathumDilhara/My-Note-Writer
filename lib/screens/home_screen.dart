import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset("assets/logo.png"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: PopupMenuButton(
              color: AppColors.primWhiteColor,
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
                        Icon(Icons.help),
                        SizedBox(width: 10),
                        Text("Help"),
                      ],
                    ),
                  ),

                  PopupMenuItem(
                    value: "Settings",
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 10),
                        Text("Settings"),
                      ],
                    ),
                  ),

                  PopupMenuItem(
                    value: "Contact_Us",
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.contacts),
                        SizedBox(width: 10),
                        Text("Contact Us"),
                      ],
                    ),
                  ),
                ];
              },
              padding: EdgeInsets.only(right: 50),
              onSelected: (value) {
                if (value == "Settings") {
                  GoRouter.of(context).push("/${AppRouterPaths.settingsScreen}");
                } else if (value == "Help") {
                  GoRouter.of(context).push("/${AppRouterPaths.helpScreen}");
                } else if (value == "Contact_Us") {
                  GoRouter.of(context).push("/${AppRouterPaths.contactUsScreen}");
                }

              },
              child: Icon(Icons.more_vert, size: 30),
            ),
          ),
        ],
        title: Text("MyNoteWriter"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primButtonBGColor,
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
