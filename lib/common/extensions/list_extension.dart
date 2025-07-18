import 'dart:math' as math;

extension NullableListExtensions<T> on List<T>? {
  bool get empty => this == null || this!.isEmpty;
  bool get notEmpty => this != null && this!.isNotEmpty;
}

extension ListExtensions<T> on List<T> {
  List<T> get distinct => toSet().toList();
  List<T> distinctBy(dynamic Function(T) getProp) {
    List<T> distinctCopy = [];
    for (T entry in this) {
      if (distinctCopy.any((c) => getProp(c) == getProp(entry))) continue;
      distinctCopy.add(entry);
    }
    return distinctCopy;
  }

  List<T> sortedCopy(int Function(T a, T b) compare) {
    List<T> copy = List.of(this);
    copy.sort(compare);
    return copy;
  }

  List<T> insertBetweenItems(T Function() getObject) {
    if (isEmpty) return [];
    return [
      for (int i = 0; i < length - 1; i++) ...[this[i], getObject()],
      last,
    ];
  }
}

extension StringListExtensions on List<String> {
  List<String> get sorted => sortedCopy((a, b) => a.compareTo(b));
}

extension NumberListExtensions<T extends num> on List<T> {
  num get sum => isEmpty ? 0 : fold(0, (all, v) => all += v);
  num get min => isEmpty ? 0 : reduce(math.min);
  num get max => isEmpty ? 0 : reduce(math.max);
  double get avg => isEmpty ? 0 : fold(0.0, (total, v) => total + v) / length;
  List<T> get sorted => sortedCopy((a, b) => a.compareTo(b));
}
