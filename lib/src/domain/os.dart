enum InfoOS {
  android,
  ios,
  macos,
  windows,
  fuchsia,
  linux,
  unknown;

  bool get isAndroid => this == InfoOS.android;
  bool get isIOS => this == InfoOS.ios;
  bool get isMacOS => this == InfoOS.macos;
  bool get isWindows => this == InfoOS.windows;
  bool get isFuchsia => this == InfoOS.fuchsia;
  bool get isLinux => this == InfoOS.linux;
  bool get isUnknown => this == InfoOS.unknown;
}
