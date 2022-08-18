enum InfoType {
  desktop,
  mobile,
  tablet,
  unknown;

  bool get isDesktop => this == InfoType.desktop;
  bool get isMobile => this == InfoType.mobile;
  bool get isTablet => this == InfoType.tablet;
  bool get isUnknown => this == InfoType.unknown;
}
