import 'package:flutter/material.dart';
import 'package:info_kit/info_kit.dart';

class DefaultInfoSize {
  static const phone = InfoSize(BoxConstraints(maxWidth: 480));
  static const tablet = InfoSize(BoxConstraints(maxWidth: 768));
  static const desktop = InfoSize(BoxConstraints(minWidth: 769));

  static const InfoSize fallbackSize = phone;
}
