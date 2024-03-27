import 'package:info_kit/info_kit.dart';

class InfoSizeData<T> {
  final T fallback;
  final Map<InfoSize, T>? _sizeData;

  InfoSizeData({
    required this.fallback,
    T? phone,
    T? tablet,
    T? desktop,
  }) : _sizeData = {
          if (phone != null) InfoKit.sizes.phone: phone,
          if (tablet != null) InfoKit.sizes.tablet: tablet,
          if (desktop != null) InfoKit.sizes.desktop: desktop,
        };

  T get value => _sizeData?[InfoKit.size] ?? fallback;
}
