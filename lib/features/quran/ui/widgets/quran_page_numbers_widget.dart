import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import '../../../../core/constants/app_constants.dart';

class QuranPageNumbersWidget extends StatelessWidget {
  final List<dynamic> pageNumbers;

  const QuranPageNumbersWidget({
    super.key,
    required this.pageNumbers,
  });

  @override
  Widget build(BuildContext context) {
    if (pageNumbers.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: QuranConstants.defaultPadding),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    color: QuranColors.primary,
                    size: 20,
                  ),
                  SizedBox(width: QuranConstants.smallPadding),
                  Text(
                    "صفحات القرآن",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: QuranColors.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
        ListView.separated(
          reverse: true,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: QuranConstants.defaultPadding),
              decoration: BoxDecoration(
                color: QuranColors.surface,
                borderRadius: BorderRadius.circular(QuranConstants.cardBorderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: QuranConstants.largePadding,
                  vertical: QuranConstants.smallPadding,
                ),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: QuranColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      pageNumbers[index].toString(),
                      style: const TextStyle(
                        color: QuranColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  getSurahName(getPageData(pageNumbers[index])[0]["surah"]),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: QuranColors.textPrimary,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: QuranColors.primary,
                  size: 16,
                ),
                onTap: () {
                  // Add navigation to page
                },
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: QuranConstants.smallPadding),
          itemCount: pageNumbers.length,
        ),
      ],
    );
  }
}