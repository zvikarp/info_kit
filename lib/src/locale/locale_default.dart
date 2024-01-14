import 'dart:io';

class LocalePlatform {
  static String? get locale => Platform.localeName.substring(0, 2);
}
