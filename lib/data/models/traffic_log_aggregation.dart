import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/common/extensions/model_ui_extension.dart';
import 'package:netguard/data/data.dart';

part 'traffic_log_aggregation.freezed.dart';

@Freezed(copyWith: true, equal: true, toStringOverride: false)
class TrafficLogAggregation with _$TrafficLogAggregation {
  TrafficLogAggregation({
    this.latest = 0,
    this.countAllowed = 0,
    this.countBlocked = 0,
    this.sizeAllowed = 0,
    this.sizeBlocked = 0,
  });
  @override
  final int latest;

  @override
  final int countAllowed;
  @override
  final int countBlocked;
  int get count => countAllowed + countBlocked;
  @override
  final int sizeAllowed;
  @override
  final int sizeBlocked;
  int get size => sizeAllowed + sizeBlocked;

  @mustBeOverridden
  String get label => "";

  @mustBeOverridden
  @mustCallSuper
  TrafficLogAggregation add(TrafficLog log) {
    return copyWith(
      sizeAllowed: log.allowed ? sizeAllowed + log.size : sizeAllowed,
      countAllowed: log.allowed ? countAllowed + 1 : countAllowed,
      sizeBlocked: !log.allowed ? sizeBlocked + log.size : sizeBlocked,
      countBlocked: !log.allowed ? countBlocked + 1 : countBlocked,
      latest: log.time > latest ? log.time : latest,
    );
    // if (log.allowed) {
    //   sizeAllowed += log.size;
    //   countAllowed++;
    // } else {
    //   sizeBlocked += log.size;
    //   countBlocked++;
    // }
    // if (log.time > latest) latest = log.time;
  }

  @mustBeOverridden
  bool matches(TrafficLog log) => false;

  // @override
  // @mustCallSuper
  // bool operator ==(Object other) {
  //   return other is TrafficLogAggregation &&
  //       countAllowed == other.countAllowed &&
  //       countBlocked == other.countBlocked &&
  //       sizeAllowed == other.sizeAllowed &&
  //       sizeBlocked == other.sizeBlocked;
  //}

  // @override
  // int get hashCode => identityHashCode(this);
}

@Freezed(copyWith: true, equal: true, toStringOverride: false)
class TrafficLogByApplication extends TrafficLogAggregation
    with _$TrafficLogByApplication {
  TrafficLogByApplication._({
    this.application,
    super.latest,
    super.countAllowed,
    super.countBlocked,
    super.sizeAllowed,
    super.sizeBlocked,
  });

  factory TrafficLogByApplication({
    Application? application,
    @Default(0) int latest,
    @Default(0) int countAllowed,
    @Default(0) int countBlocked,
    @Default(0) int sizeAllowed,
    @Default(0) int sizeBlocked,
  }) = _TrafficLogByApplication;
  @override
  final Application? application;

  @override
  bool matches(TrafficLog log) => application?.packageName == log.packageName;

  @override
  TrafficLogByApplication add(TrafficLog log) {
    return super.add(log) as TrafficLogByApplication;
  }

  @override
  String get label => application.label;

  //
  // @override
  // bool operator ==(Object other) {
  //   return other is TrafficLogByApplication &&
  //       super == other &&
  //       application?.packageName == other.application?.packageName;
  //}
}

@Freezed(copyWith: true, equal: true, toStringOverride: false)
class TrafficLogByDestination extends TrafficLogAggregation
    with _$TrafficLogByDestination {
  TrafficLogByDestination._({
    required this.destination,
    super.latest,
    super.countAllowed,
    super.countBlocked,
    super.sizeAllowed,
    super.sizeBlocked,
  });

  factory TrafficLogByDestination({
    required String destination,
    @Default(0) int latest,
    @Default(0) int countAllowed,
    @Default(0) int countBlocked,
    @Default(0) int sizeAllowed,
    @Default(0) int sizeBlocked,
  }) = _TrafficLogByDestination;
  @override
  final String destination;

  @override
  bool matches(TrafficLog log) => destination == log.destination;

  @override
  TrafficLogByDestination add(TrafficLog log) {
    return super.add(log) as TrafficLogByDestination;
  }

  @override
  String get label => destination;

  // @override
  // bool operator ==(Object other) {
  //   return other is TrafficLogByDestination &&
  //       super == other &&
  //       destination == other.destination;
  //}
}

@Freezed(copyWith: true, equal: true, toStringOverride: false)
class TrafficLogByConnection extends TrafficLogAggregation
    with _$TrafficLogByConnection {
  TrafficLogByConnection._({
    this.packageName,
    required this.protocol,
    required this.dport,
    required this.destination,
    super.latest,
    super.countAllowed,
    super.countBlocked,
    super.sizeAllowed,
    super.sizeBlocked,
  });

  factory TrafficLogByConnection({
    String? packageName,
    required int protocol,
    required int dport,
    required String destination,
    @Default(0) int latest,
    @Default(0) int countAllowed,
    @Default(0) int countBlocked,
    @Default(0) int sizeAllowed,
    @Default(0) int sizeBlocked,
  }) = _TrafficLogByConnection;
  factory TrafficLogByConnection.fromLog(TrafficLog log) =>
      TrafficLogByConnection(
        packageName: log.packageName,
        protocol: log.protocol,
        dport: log.dport,
        destination: log.destination,
      );

  @override
  final String? packageName;
  @override
  final int protocol;
  @override
  final int dport;
  @override
  final String destination;

  @override
  bool matches(TrafficLog log) =>
      packageName == log.packageName &&
      protocol == log.protocol &&
      dport == log.dport &&
      destination == log.destination;

  @override
  TrafficLogByConnection add(TrafficLog log) {
    return super.add(log) as TrafficLogByConnection;
  }

  @override
  String get label =>
      "${NetworkingTools.toPortAwareProtocol(protocol, dport)} $destination:$dport";

  // @override
  // bool operator ==(Object other) {
  //   return other is TrafficLogByConnection &&
  //       super == other &&
  //       packageName == other.packageName &&
  //       protocol == other.protocol &&
  //       dport == other.dport &&
  //       destination == other.destination;
  //}
}
