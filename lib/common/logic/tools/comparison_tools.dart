import 'package:netguard/data/data.dart';

class ComparisonTools {
  static int Function(T, T) _compare<T>(
    Comparable Function(T) getValue, {
    bool reverse = false,
  }) =>
      (T a, T b) => reverse
      ? getValue(b).compareTo(getValue(a))
      : getValue(a).compareTo(getValue(b));

  static int Function(T, T)? getSortingFunction<T>(
    LogSorting sorting, {
    Application? Function(T)? getApplication,
    int Function(T)? getTime,
    String Function(T)? getName,
    double Function(T)? getVolume,
    double Function(T)? getVolumeBlocked,
  }) {
    return switch (sorting) {
      LogSorting.application =>
        getApplication == null
            ? null
            : _compare<T>((T x) => getApplication(x)?.label ?? "Unknown"),
      LogSorting.time =>
        getTime == null ? null : _compare((T x) => getTime(x), reverse: true),
      LogSorting.name => getName == null ? null : _compare((T x) => getName(x)),
      LogSorting.volume =>
        getVolume == null
            ? null
            : _compare((T x) => getVolume(x), reverse: true),
      LogSorting.blockedVolume =>
        getVolumeBlocked == null
            ? null
            : _compare((T x) => getVolumeBlocked(x), reverse: true),
      _ => null,
    };
  }
}
