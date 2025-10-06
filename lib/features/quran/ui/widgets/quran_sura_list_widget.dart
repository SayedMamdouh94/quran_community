import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import 'quran_sura_item_widget.dart';

class QuranSuraListWidget extends StatelessWidget {
  final List<dynamic> filteredData;
  final dynamic suraJsonData;

  const QuranSuraListWidget({
    super.key,
    required this.filteredData,
    required this.suraJsonData,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: QuranConstants.smallPadding),
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        return QuranSuraItemWidget(
          suraData: filteredData[index],
          index: index,
          suraJsonData: suraJsonData,
        );
      },
    );
  }
}