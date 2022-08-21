import 'package:flutter/material.dart';
import 'package:info_kit/info_kit.dart';

class DefaultInfoSize {
  static const List<InfoSize> sizes = [
    InfoSize('phone', BoxConstraints(maxWidth: 480)),
    InfoSize('tablet', BoxConstraints(maxWidth: 768)),
    InfoSize('desktop', BoxConstraints(minWidth: 769)),
    InfoSize('unknown', BoxConstraints()),
  ];

  static const InfoSize fallbackSize = InfoSize('unknown', BoxConstraints());
}
