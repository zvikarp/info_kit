import 'package:info_kit/info_kit.dart';
import '../utils/string_extension.dart';

class InfoPlatformData<T> {
  final T fallback;
  final Map<InfoPlatform, T>? _platformData;

  InfoPlatformData({
    required this.fallback,
    T? web,
    T? android,
    T? ios,
    T? fuchsia,
    T? macos,
    T? windows,
    T? linux,
    T? unknown,
  }) : _platformData = {
          if (web != null) InfoPlatform.web: web,
          if (android != null) InfoPlatform.android: android,
          if (ios != null) InfoPlatform.ios: ios,
          if (fuchsia != null) InfoPlatform.fuchsia: fuchsia,
          if (macos != null) InfoPlatform.macos: macos,
          if (windows != null) InfoPlatform.windows: windows,
          if (linux != null) InfoPlatform.linux: linux,
          if (unknown != null) InfoPlatform.unknown: unknown,
        };

  factory InfoPlatformData.fromMap({
    required fallback,
    Map<String, T>? map,
  }) {
    Map<InfoPlatform, T>? platformData = map?.map<InfoPlatform, T>(
      (String key, T value) => MapEntry<InfoPlatform, T>(
        key.toEnum(InfoPlatform.values) ?? InfoPlatform.unknown,
        value,
      ),
    );
    return InfoPlatformData(
      fallback: fallback,
      android: platformData?[InfoPlatform.android],
      ios: platformData?[InfoPlatform.ios],
      fuchsia: platformData?[InfoPlatform.fuchsia],
      macos: platformData?[InfoPlatform.macos],
      windows: platformData?[InfoPlatform.windows],
      linux: platformData?[InfoPlatform.linux],
      web: platformData?[InfoPlatform.web],
      unknown: platformData?[InfoPlatform.unknown],
    );
  }

  T get value => _platformData?[InfoKit.platform] ?? fallback;
}
