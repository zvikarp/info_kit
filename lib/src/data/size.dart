import 'package:flutter/material.dart';
import 'package:info_kit/info_kit.dart';

class DefaultInfoSize {
  static const List<InfoSize> sizes = [
    InfoSize('phone', BoxConstraints(maxHeight: 480)),
    InfoSize('tablet', BoxConstraints(maxHeight: 768)),
    InfoSize('desktop', BoxConstraints(maxHeight: 1200)),
    InfoSize('unknown', BoxConstraints()),
  ];

  static const InfoSize fallbackSize = InfoSize('unknown', BoxConstraints());
}
