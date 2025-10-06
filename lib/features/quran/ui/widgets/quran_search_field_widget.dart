import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class QuranSearchFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String searchQuery;
  final Function(String) onChanged;
  final VoidCallback onClear;

  const QuranSearchFieldWidget({
    super.key,
    required this.controller,
    required this.searchQuery,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(QuranConstants.defaultPadding),
      decoration: BoxDecoration(
        color: QuranColors.surface,
        borderRadius: BorderRadius.circular(QuranConstants.buttonBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        textDirection: TextDirection.rtl,
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          color: QuranColors.textPrimary,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'ابحث في القرآن الكريم...',
          hintStyle: TextStyle(
            color: QuranColors.textHint.withOpacity(0.6),
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: QuranColors.textHint.withOpacity(0.6),
          ),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: QuranColors.textHint.withOpacity(0.6),
                  ),
                  onPressed: onClear,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(QuranConstants.buttonBorderRadius),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.05),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: QuranConstants.largePadding,
            vertical: QuranConstants.defaultPadding,
          ),
        ),
      ),
    );
  }
}