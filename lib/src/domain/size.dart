import 'package:flutter/material.dart';

enum InfoSize {
  phone(BoxConstraints(maxWidth: 480)),
  tablet(BoxConstraints(maxWidth: 768)),
  desktop(BoxConstraints(minWidth: 769));

  final BoxConstraints constraints;

  const InfoSize(this.constraints);

  bool get isPhone => this == InfoSize.phone;
  bool get isTablet => this == InfoSize.tablet;
  bool get isDesktop => this == InfoSize.desktop;
}
