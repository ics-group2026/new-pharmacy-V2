import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

// Single point of change if the localization package is ever swapped.
// All translation calls in the app go through here — never call .tr() directly.
abstract class AppTranslations {
  static String t(
    String key, {
    List<String>? args,
    Map<String, String>? namedArgs,
    BuildContext? context,
  }) {
    return key.tr(args: args, namedArgs: namedArgs ?? {});
  }
}
