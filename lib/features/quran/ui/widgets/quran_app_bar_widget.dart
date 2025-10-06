import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class QuranAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const QuranAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "القرآن الكريم",
        style: QuranTextStyles.appBarTitle,
      ),
      centerTitle: true,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: QuranLightColors.primary,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
