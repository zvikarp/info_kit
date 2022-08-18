import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:info_kit/info_kit.dart';
import 'package:info_kit/src/data/flavor.dart';
import 'package:info_kit/src/utils/locale_extension.dart';
import 'package:universal_io/io.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'utils/string_extension.dart';

class InfoKit {
  InfoKit._();

  static Future<void> init({
    bool flavorEnabled = true,
    List<InfoFlavor> flavors = DefaultInfoFlavor.flavors,
    InfoFlavor fallbackFlavor = DefaultInfoFlavor.fallbackFlavor,
    String flavorEnvKey = DefaultInfoFlavor.flavorEnvKey,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    PackageInfo info = await PackageInfo.fromPlatform();
    _buildNumber = int.parse(info.buildNumber);
    _version = info.version;

    if (flavorEnabled) {
      // as there is no built in flavor support for web, we pass the flavor on
      // run as `--dart-define=flavor=<FLAVOR>`
      String flavor = String.fromEnvironment(flavorEnvKey);
      _flavor = flavors.firstWhere((f) => f.name == flavor,
          orElse: () => fallbackFlavor);
    }
  }

  // screen size
  static InfoSize _size = InfoSize.unknown;

  static void setSize(Size size) {
    final double width = size.width;
    for (InfoSize w in InfoSize.values) {
      if (width <= w.px) {
        _size = w;
        return;
      }
    }
    _size = InfoSize.desktop;
  }
  static InfoSize get size => _size;

  // origin
  static String get origin => platform.isWeb ? Uri.base.origin : '';

  // locale
  static String get _localeName => Platform.localeName;
  static Locale get locale => LocaleExtension.fromString(_localeName);

  // platform
  static InfoPlatform get platform {
    if (kIsWeb) return InfoPlatform.web;
    return os.name.toEnum(InfoPlatform.values) ?? InfoPlatform.unknown;
  }

  // os
  static InfoOS get os =>
      Platform.operatingSystem.toEnum(InfoOS.values) ?? InfoOS.unknown;

  // type
  static InfoType get type => (os == InfoOS.android || os == InfoOS.ios)
      ? InfoType.mobile
      : (os == InfoOS.macos || os == InfoOS.windows)
          ? InfoType.desktop
          : InfoType.unknown;

  // flavor
  static late InfoFlavor _flavor;
  static InfoFlavor get flavor => _flavor;

  // mode
  static InfoMode get mode => kDebugMode ? InfoMode.debug : InfoMode.release;

  // build number
  static late int _buildNumber;
  static int get buildNumber => _buildNumber;

  // version
  static late String _version;
  static String get version => _version;
}
