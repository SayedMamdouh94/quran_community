import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:string_validator/string_validator.dart';
import '../../../../core/constants/app_constants.dart';
import '../widgets/quran_app_bar_widget.dart';
import '../widgets/quran_search_field_widget.dart';
import '../widgets/quran_page_numbers_widget.dart';
import '../widgets/quran_sura_list_widget.dart';
import '../widgets/quran_verse_search_results_widget.dart';

class QuranSuraScreen extends StatefulWidget {
  final dynamic suraJsonData;

  const QuranSuraScreen({super.key, required this.suraJsonData});

  @override
  State<QuranSuraScreen> createState() => _QuranSuraScreenState();
}

class _QuranSuraScreenState extends State<QuranSuraScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  bool _isLoading = true;
  String _searchQuery = "";
  dynamic _filteredData;
  dynamic _ayatFiltered;
  List<dynamic> _pageNumbers = [];

  @override
  void initState() {
    super.initState();
    _addFilteredData();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _addFilteredData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      _filteredData = widget.suraJsonData;
      _isLoading = false;
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });

    if (value.isEmpty) {
      setState(() {
        _filteredData = widget.suraJsonData;
        _pageNumbers = [];
        _ayatFiltered = null;
      });
      return;
    }

    // Handle page number search
    if (_searchQuery.isNotEmpty &&
        isInt(_searchQuery) &&
        toInt(_searchQuery) < QuranConstants.maxQuranPages + 1 &&
        toInt(_searchQuery) > 0) {
      setState(() {
        _pageNumbers = [toInt(_searchQuery)];
      });
    } else {
      setState(() {
        _pageNumbers = [];
      });
    }

    // Handle text search
    if (_searchQuery.length > 3 || _searchQuery.contains(" ")) {
      setState(() {
        _ayatFiltered = searchWords(_searchQuery);
        _filteredData = widget.suraJsonData.where((sura) {
          final suraName = sura['englishName'].toLowerCase();
          final suraNameTranslated = getSurahNameArabic(sura["number"]);

          return suraName.contains(_searchQuery.toLowerCase()) ||
              suraNameTranslated.contains(_searchQuery.toLowerCase());
        }).toList();
      });
    }
  }

  void _onClearSearch() {
    _textEditingController.clear();
    setState(() {
      _searchQuery = "";
      _filteredData = widget.suraJsonData;
      _pageNumbers = [];
      _ayatFiltered = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QuranColors.background,
      appBar: const QuranAppBarWidget(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: QuranColors.primary,
              ),
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                // Search Field
                QuranSearchFieldWidget(
                  controller: _textEditingController,
                  searchQuery: _searchQuery,
                  onChanged: _onSearchChanged,
                  onClear: _onClearSearch,
                ),

                // Page Numbers Section
                QuranPageNumbersWidget(pageNumbers: _pageNumbers),

                // Sura List
                QuranSuraListWidget(
                  filteredData: _filteredData,
                  suraJsonData: widget.suraJsonData,
                ),

                // Verse Search Results
                QuranVerseSearchResultsWidget(ayatFiltered: _ayatFiltered),

                // Bottom spacing
                const SizedBox(height: QuranConstants.largePadding),
              ],
            ),
    );
  }
}
