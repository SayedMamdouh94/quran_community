import 'package:flutter/material.dart';

import '../../localization/generated/l10n.dart';

extension NavigationEx on BuildContext {
  Future<Object?> pushNamed(String routeName, {Object? arguments}) async {
    return Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  Future<Object?> pushReplacementNamed(String routeName,
      {Object? arguments}) async {
    return Navigator.pushReplacementNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  void pop({Object? data}) {
    Navigator.pop(this, data);
  }

  Future<Object?> pushNamedAndRemoveUntil(String routeName,
          {Object? arguments, String? initialRoute}) =>
      Navigator.pushNamedAndRemoveUntil(
        this,
        routeName,
        (route) => false,
        arguments: arguments,
      );
}

extension FocusEx on BuildContext {
  void requestFocus(FocusNode focusNode) {
    FocusScope.of(this).requestFocus(focusNode);
  }

  void unfocus() {
    FocusScope.of(this).unfocus();
  }

  void nextFocus() {
    FocusScope.of(this).nextFocus();
  }
}

extension LocaleEx on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
}

extension ThemeEx on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension MediaQueryEx on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;
}
