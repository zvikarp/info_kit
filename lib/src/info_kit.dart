import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:info_kit/info_kit.dart';
import 'package:info_kit/src/utils/locale_extension.dart';
import 'package:universal_io/io.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'utils/string_extension.dart';
import 'utils/box_constrains_extension.dart';
import 'locale/locale_default.dart'
    if (dart.library.html) 'locale/locale_web.dart';

/// Provides all basic info about your application. App flavor, Version, Device
/// size, Flavor specific environment variables, and more.
class InfoKit {
  InfoKit._();

  /// Initializes the [InfoKit]. All parameters are optional.
  ///
  /// If the app doesn't use flavors, set [flavorEnabled] to false. otherwise,
  /// provide a list of [flavors] that the app uses, there is a default list
  /// set. Set the [fallbackFlavor] to a default flavor.
  ///
  /// Set a list of supported [sizes] if the app uses different sizes, and a
  /// [fallbackSize] to a default size.
  ///
  /// If the app doesn't use environment variables, set [envEnabled] to false.
  /// If the app don't use specific environment variables for each flavor, set
  /// [envFlavorEnabled] to false. If the app doesn't use specific environment
  /// variables for each platform, set [envFlavorPerPlatformEnabled] to false.
  /// Set the [envFolder] to the folder where the environment variables are
  /// stored.
  static Future<void> init({
    bool flavorEnabled = true,
    List<InfoFlavor> flavors = DefaultInfoFlavor.flavors,
    InfoFlavor fallbackFlavor = DefaultInfoFlavor.fallbackFlavor,
    InfoSize fallbackSize = InfoSize.phone,
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
  static InfoSize get size => _size;
  static late InfoSize _size;

  static BoxConstraints? _screen;
  static BoxConstraints? get screen => _screen;

  /// set the size of the device based on given []
  static void setConstrains(BoxConstraints constrains) {
    _screen = constrains;
    _size = InfoSize.values.firstWhere(
        (s) => s.constraints.contains(constrains),
        orElse: () => _size);
  }

  /// origin url on web platform, otherwise an empty string
  static String get origin => platform.isWeb ? Uri.base.origin : '';

  /// device's language
  static Locale get locale =>
      LocaleExtension.fromString(LocalePlatform.locale ?? '');

  /// device platform, (ios app, web app, macos app), etc
  static InfoPlatform get platform {
    if (kIsWeb) return InfoPlatform.web;
    return os.name.toEnum(InfoPlatform.values) ?? InfoPlatform.unknown;
  }

  /// device's operating system
  static InfoOS get os =>
      Platform.operatingSystem.toEnum(InfoOS.values) ?? InfoOS.unknown;

  /// build flavor of the app
  static InfoFlavor get flavor => _flavor;
  static late InfoFlavor _flavor;

  /// if release build or debug
  static InfoMode get mode => kDebugMode ? InfoMode.debug : InfoMode.release;

  /// build number of the app (ex. 24)
  static int get buildNumber => _buildNumber;
  static late int _buildNumber;

  /// version of the app (ex. 1.0.0)
  static String get version => _version;
  static late String _version;

  /// package name of the app (ex. com.example.app)
  static String get packageName => _packageName;
  static late String _packageName;

  /// app name of the app (ex. My App)
  static String get appName => _appName;
  static late String _appName;

  static String? storeUrl(String? appleAppId) => InfoPlatformData(
        android: 'https://play.google.com/store/apps/details?id=$packageName',
        ios: appleAppId != null
            ? 'https://apps.apple.com/app/$appleAppId'
            : null,
        fallback: null,
      ).value;
}
