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
    required T fallback,
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

  factory InfoPlatformData.fromAny(dynamic data) {
    if (data is Map) {
      if (data.isEmpty) throw ArgumentError('data cannot be empty');
      if (!data.containsKey('fallback')) {
        throw ArgumentError('data must contain a fallback value');
      }
      return InfoPlatformData.fromMap(
        fallback: data['fallback'],
        map: data.cast<String, T>(),
      );
    } else {
      return InfoPlatformData(
        fallback: data,
      );
    }
  }

  T get value => _platformData?[InfoKit.platform] ?? fallback;
}
