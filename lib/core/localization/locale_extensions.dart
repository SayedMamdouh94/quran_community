import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';

extension LocaleExtensions on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
}
