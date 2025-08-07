enum LogSorting {
  time,
  volume,
  blockedVolume,
  name,
  application;

  @override
  String toString() => switch (this) {
    time => "Time",
    volume => "Traffic Volume",
    blockedVolume => "Blocked Traffic Volume",
    name => "Name",
    application => "Application",
  };
}

enum VolumeType {
  count,
  bytes;

  @override
  String toString() => switch (this) {
    count => "Count",
    bytes => "Bytes",
  };
}

enum GroupType {
  application,
  destination;

  @override
  String toString() => switch (this) {
    application => "App",
    destination => "Host",
  };
}

enum ChartType {
  pie,
  bar;

  @override
  String toString() => switch (this) {
    pie => "Pie",
    bar => "Bar",
  };
}
