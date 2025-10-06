import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

import '../../../../core/constants/app_constants.dart';

class QuranVerseSearchResultsWidget extends StatelessWidget {
  final dynamic ayatFiltered;

  const QuranVerseSearchResultsWidget({
    super.key,
    required this.ayatFiltered,
  });

  @override
  Widget build(BuildContext context) {
    if (ayatFiltered == null) return const SizedBox.shrink();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: QuranConstants.defaultPadding,
            right: QuranConstants.defaultPadding,
            top: QuranConstants.defaultPadding,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search_rounded,
                color: QuranLightColors.primary,
                size: 20,
              ),
              const SizedBox(width: QuranConstants.smallPadding),
              const Text(
                "نتائج البحث في الآيات",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: QuranLightColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: QuranConstants.smallPadding,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: QuranLightColors.primary.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(QuranConstants.cardBorderRadius),
                ),
                child: Text(
                  "${ayatFiltered["occurences"] > QuranConstants.maxSearchResults ? "${QuranConstants.maxSearchResults}+" : ayatFiltered["occurences"]} نتيجة",
                  style: const TextStyle(
                    fontSize: 12,
                    color: QuranLightColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:
              ayatFiltered["occurences"] > QuranConstants.maxSearchResults
                  ? QuranConstants.maxSearchResults
                  : ayatFiltered["occurences"],
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: QuranConstants.defaultPadding,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: QuranLightColors.surface,
                borderRadius:
                    BorderRadius.circular(QuranConstants.cardBorderRadius),
                border: Border.all(
                  color: QuranLightColors.primary.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(QuranConstants.cardBorderRadius),
                  onTap: () async {
                    // Add navigation to specific verse
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.all(QuranConstants.defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Verse header
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: QuranConstants.smallPadding,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: QuranLightColors.primary,
                                borderRadius: BorderRadius.circular(
                                    QuranConstants.smallPadding),
                              ),
                              child: Text(
                                "سورة ${getSurahNameArabic(ayatFiltered["result"][index]["surah"])}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: QuranLightColors.textSecondary
                                  .withOpacity(0.5),
                              size: 14,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Verse text
                        Text(
                          getVerse(
                            ayatFiltered["result"][index]["surah"],
                            ayatFiltered["result"][index]["verse"],
                            verseEndSymbol: true,
                          ),
                          textDirection: TextDirection.rtl,
                          style: QuranTextStyles.verseText,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
