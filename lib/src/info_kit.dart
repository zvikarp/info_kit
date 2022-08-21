import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:info_kit/info_kit.dart';
import 'package:info_kit/src/data/flavor.dart';
import 'package:info_kit/src/data/size.dart';
import 'package:info_kit/src/utils/locale_extension.dart';
import 'package:universal_io/io.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'utils/string_extension.dart';
import 'utils/box_constrains_extension.dart';

class InfoKit {
  InfoKit._();

  static Future<void> init({
    bool flavorEnabled = true,
    List<InfoFlavor> flavors = DefaultInfoFlavor.flavors,
    InfoFlavor fallbackFlavor = DefaultInfoFlavor.fallbackFlavor,
    List<InfoSize> sizes = DefaultInfoSize.sizes,
    InfoSize fallbackSize = DefaultInfoSize.fallbackSize,
    bool envEnabled = true,
    bool envFlavorEnabled = true,
    bool envFlavorPerPlatformEnabled = true,
    String envFolder = 'env',
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    PackageInfo info = await PackageInfo.fromPlatform();
    _buildNumber = int.parse(info.buildNumber);
    _version = info.version;
    _packageName = info.packageName;
    _appName = info.appName;
    _sizes = sizes;
    _size = fallbackSize;

    if (flavorEnabled) {
      // as there is no built in flavor support for web, we pass the flavor on
      // run as `--dart-define=flavor=<FLAVOR>`
      String flavor =
          const String.fromEnvironment(DefaultInfoFlavor.flavorEnvKey);
      _flavor = flavors.firstWhere((f) => f.name == flavor,
          orElse: () => fallbackFlavor);
    }

    if (envEnabled) {
      Map<String, String> env = {};
      if (envFlavorPerPlatformEnabled) {
        await dotenv.load(
            fileName: '$envFolder/${platform.name}/.env.${flavor.name}');
        env.addAll(dotenv.env);
      }
      if (envFlavorEnabled) {
        await dotenv.load(
            fileName: '$envFolder/.env.${flavor.name}', mergeWith: env);
        env.addAll(dotenv.env);
      }
      await dotenv.load(fileName: '$envFolder/.env', mergeWith: env);
    }
  }

  /// size of the device, based on a list of supported sizes
  static late List<InfoSize> _sizes;
  static late InfoSize _size;

  static void setConstrains(BoxConstraints size) {
    _size = _sizes.firstWhere((s) => s.constraints.contains(size),
        orElse: () => _size);
  }

  static InfoSize get size => _size;

  /// origin url on web platform, otherwise an empty string
  static String get origin => platform.isWeb ? Uri.base.origin : '';

  /// device's language
  static String get _localeName => Platform.localeName;
  static Locale get locale => LocaleExtension.fromString(_localeName);

  /// device platform, (ios app, web app, macos app), etc
  static InfoPlatform get platform {
    if (kIsWeb) return InfoPlatform.web;
    return os.name.toEnum(InfoPlatform.values) ?? InfoPlatform.unknown;
  }

  /// device's operating system
  static InfoOS get os =>
      Platform.operatingSystem.toEnum(InfoOS.values) ?? InfoOS.unknown;

  //. build flavor
  static late InfoFlavor _flavor;
  static InfoFlavor get flavor => _flavor;

  /// if release build or debug
  static InfoMode get mode => kDebugMode ? InfoMode.debug : InfoMode.release;

  /// build number
  static late int _buildNumber;
  static int get buildNumber => _buildNumber;

  /// version
  static late String _version;
  static String get version => _version;

  /// package name
  static late String _packageName;
  static String get packageName => _packageName;

  /// app name
  static late String _appName;
  static String get appName => _appName;
}
