class ApplicationSetting {
  ApplicationSetting({
    required this.packageName,
    this.filter = false,
    this.blockAll = false,
  });

  String packageName;

  bool filter;

  bool blockAll;
}
