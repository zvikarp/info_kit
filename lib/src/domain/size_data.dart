import 'package:info_kit/info_kit.dart';
import '../utils/string_extension.dart';

class InfoSizeData<T> {
  final T fallback;
  final Map<InfoSize, T>? _sizeData;

  InfoSizeData({
    required this.fallback,
    T? phone,
    T? tablet,
    T? desktop,
  }) : _sizeData = {
          if (phone != null) InfoSize.phone: phone,
          if (tablet != null) InfoSize.tablet: tablet,
          if (desktop != null) InfoSize.desktop: desktop,
        };

  factory InfoSizeData.fromMap({
    required fallback,
    Map<String, T>? map,
  }) {
    Map<InfoSize, T>? sizeData = map?.map<InfoSize, T>(
      (String key, T value) => MapEntry<InfoSize, T>(
        key.toEnum(InfoSize.values) ?? InfoSize.phone,
        value,
      ),
    );
    return InfoSizeData(
      fallback: fallback,
      phone: sizeData?[InfoSize.phone],
      tablet: sizeData?[InfoSize.tablet],
      desktop: sizeData?[InfoSize.desktop],
    );
  }

  T get value => _sizeData?[InfoKit.size] ?? fallback;
}
