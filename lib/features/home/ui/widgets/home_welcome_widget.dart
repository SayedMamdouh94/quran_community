import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class HomeWelcomeWidget extends StatelessWidget {
  const HomeWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(QuranConstants.defaultPadding),
      padding: const EdgeInsets.all(QuranConstants.largePadding),
      decoration: BoxDecoration(
        color: QuranLightColors.cardBackground,
        borderRadius: BorderRadius.circular(QuranConstants.borderRadius),
        border: Border.all(
          color: QuranLightColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.book_rounded,
            size: 48,
            color: QuranLightColors.primary,
          ),
          SizedBox(height: QuranConstants.smallPadding),
          Text(
            "أهلاً وسهلاً",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: QuranLightColors.textPrimary,
            ),
          ),
          SizedBox(height: QuranConstants.smallPadding),
          Text(
            "اختر طريقة قراءة القرآن الكريم",
            style: TextStyle(
              fontSize: 16,
              color: QuranLightColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
