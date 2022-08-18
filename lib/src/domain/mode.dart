enum InfoMode {
  release,
  debug;

  bool get isRelease => this == InfoMode.release;
  bool get isDebug => this == InfoMode.debug;
}