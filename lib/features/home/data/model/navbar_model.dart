import 'package:flutter/material.dart';
import 'package:quran_tutorial/core/helpers/extensions/context_extenstions.dart';
import 'package:quran_tutorial/features/home/ui/screens/home_screen.dart';
import 'package:quran_tutorial/features/my_marks/presentation/ui/my_marks_screen.dart';
import 'package:quran_tutorial/features/quran/ui/screens/quran_sura_screen.dart';

class NavBarModel {
  final String title;
  final String imagePath;
  final Widget screen;

  NavBarModel({
    required this.title,
    required this.imagePath,
    required this.screen,
  });

  static List<NavBarModel> navbarData(BuildContext context) => [
        NavBarModel(
          title: context.locale.home,
          imagePath: 'home',
          screen: const HomeScreen(),
        ),
        NavBarModel(
          title: context.locale.index,
          imagePath: 'index',
          screen: const QuranSuraScreen(suraJsonData: {}),
        ),
        NavBarModel(
          title: context.locale.myMarks,
          imagePath: 'my_marks',
          screen: const MyMarksScreen(),
        ),
        
      ];
}
