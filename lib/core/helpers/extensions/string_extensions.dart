import 'package:intl/intl.dart';


extension StringEx on String {
  String toStringAsFixed0() => num.parse(this).toStringAsFixed(0);
  int toInt() => int.parse(this);
  String noramlizeText() {
    return replaceAll('أ', 'ا').replaceAll('إ', 'ا').replaceAll('ة', 'ه');
  }

  String capitalizeFirst({characterLength = 2}) => trim()
      .split(' ')
      .map((l) => '${l[0].toUpperCase()} ')
      .take(characterLength)
      .join();

  String convertArabicToEnglishNumbers() {
    const arabicNumbers = '٠١٢٣٤٥٦٧٨٩';
    const englishNumbers = '0123456789';
    String input = this;
    for (int i = 0; i < arabicNumbers.length; i++) {
      input.replaceAll(arabicNumbers[i], englishNumbers[i]);
    }
    return input;
  }

  String? extractNumber() {
    RegExp regExp = RegExp(r'\d+');
    RegExpMatch? match = regExp.firstMatch(this);
    return match?.group(0);
  }

  String get dateLabel {
    DateTime date = DateTime.parse(this);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date == today) {
      return 'اليوم';
    } else if (date == tomorrow) {
      return 'غداً';
    } else if (date == yesterday) {
      return 'أمس';
    } else {
      // Format the date in Arabic
      DateFormat formatter = DateFormat('d MMMM yyyy', 'ar');
      return formatter.format(date);
    }
  }

  String get dateAndTimeLabel {
    DateTime date = DateTime.parse(this);
    return DateFormat('d MMMM yyyy, hh:mm a', 'ar').format(date);
  }

  String get pastTimeLabel {
    DateTime date = DateTime.parse(this);
    DateTime now = DateTime.now();
    Duration diff = now.difference(date);

    String toArabicNumber(int number) {
      final arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
      return number
          .toString()
          .split('')
          .map((d) => arabicNumbers[int.parse(d)])
          .join();
    }

    if (diff.inSeconds < 60) {
      return 'حالا';
    } else if (diff.inMinutes < 60) {
      return '${toArabicNumber(diff.inMinutes)}د';
    } else if (diff.inHours < 24) {
      return '${toArabicNumber(diff.inHours)}س';
    } else if (diff.inDays < 30) {
      return '${toArabicNumber(diff.inDays)}ي';
    } else if (diff.inDays < 365) {
      int months = (diff.inDays / 30).floor();
      return '${toArabicNumber(months)}ش';
    } else {
      int years = (diff.inDays / 365).floor();
      return '${toArabicNumber(years)}ع';
    }
  }
}

extension PathExtensions on String {
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  String get lottie => 'assets/lottie/$this.json';
  String get gif => 'assets/gifs/$this.gif';
  String get svg => 'assets/svgs/$this.svg';
}

extension NotNullOrEmptyString on String? {
  bool get notNullOrEmpty => this != null && this!.isNotEmpty;
}



