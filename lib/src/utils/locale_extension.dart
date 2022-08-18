import 'dart:ui';

extension LocaleExtension on Locale {
  static Locale fromString(String locale) {
    final List<String> parts = locale.split('_');
    if (parts.length == 1) {
      return Locale(parts.first);
    } else if (parts.length == 2) {
      return Locale(parts.first, parts.last);
    } else {
      throw const FormatException('Invalid locale format');
    }
  }
}
