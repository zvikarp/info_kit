// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html show window;

class LocalePlatform {
  static String? get locale => html.window.navigator.language.substring(0, 2);
}
