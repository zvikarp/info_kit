enum InfoSize {
  phone(480),
  tablet(768),
  desktop(1024),
  unknown(0);

  final int px;
  const InfoSize(this.px);
}
