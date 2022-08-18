enum InfoPlatform {
  web,
  android,
  ios,
  fuchsia,
  macos,
  windows,
  linux,
  unknown;

  bool get isWeb => this == InfoPlatform.web;
  bool get isAndroid => this == InfoPlatform.android;
  bool get isIOS => this == InfoPlatform.ios;
  bool get isFuchsia => this == InfoPlatform.fuchsia;
  bool get isMacOS => this == InfoPlatform.macos;
  bool get isWindows => this == InfoPlatform.windows;
  bool get isLinux => this == InfoPlatform.linux;
  bool get isUnknown => this == InfoPlatform.unknown;
}
