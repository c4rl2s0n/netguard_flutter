class PackageStatistics {
  PackageStatistics({
    required this.packageName,
    this.packetCountAllowed = 0,
    this.packetSizeAllowed = 0,
    this.packetCountBlocked = 0,
    this.packetSizeBlocked = 0,
  });
  String packageName;
  int packetCountAllowed;
  int packetSizeAllowed;
  int packetCountBlocked;
  int packetSizeBlocked;
}
