import 'package:flutter/material.dart';

extension BoxConstrainsExtension on BoxConstraints {
  static BoxConstraints fromSize(Size size) =>
      BoxConstraints.tightFor(width: size.width, height: size.height);

  bool contains(Size size) =>
      minWidth <= size.width &&
      maxWidth >= size.width &&
      minHeight <= size.height &&
      maxHeight >= size.height;
}
