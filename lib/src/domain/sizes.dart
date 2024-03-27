import 'package:flutter/material.dart';
import 'package:info_kit/info_kit.dart';
import 'package:info_kit/src/utils/box_constrains_extension.dart';

class InfoSizes {
  final InfoSize phone;
  final InfoSize tablet;
  final InfoSize desktop;

  const InfoSizes({
    this.phone = DefaultInfoSize.phone,
    this.tablet = DefaultInfoSize.tablet,
    this.desktop = DefaultInfoSize.desktop,
  });

  InfoSize getSize(BoxConstraints constraints, InfoSize fallbackSize) {
    if (phone.constraints.contains(constraints)) {
      return phone;
    } else if (tablet.constraints.contains(constraints)) {
      return tablet;
    } else if (desktop.constraints.contains(constraints)) {
      return desktop;
    } else {
      return fallbackSize;
    }
  }
}
