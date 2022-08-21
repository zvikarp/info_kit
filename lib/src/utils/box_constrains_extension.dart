import 'package:flutter/material.dart';

extension BoxConstrainsExtension on BoxConstraints {
  static BoxConstraints fromSize(Size size) =>
      BoxConstraints.tightFor(width: size.width, height: size.height);

  bool contains(BoxConstraints constraints) =>
      minWidth <= constraints.minWidth &&
      maxWidth >= constraints.maxWidth &&
      minHeight <= constraints.minHeight &&
      maxHeight >= constraints.maxHeight;
}
