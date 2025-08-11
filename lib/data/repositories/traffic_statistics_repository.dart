import 'package:collection/collection.dart';
import 'package:netguard/netguard.dart';
import 'package:drift/drift.dart';

class TrafficStatisticsRepository extends ITrafficStatisticsRepository {
  TrafficStatisticsRepository(super.db);

  @override
  Future<List<TrafficStatistics>> getAll() async {
    return await (db.trafficStatisticsTable.select()).get();
  }

  @override
  Future insert(TrafficStatistics entity) async {
    await db.trafficStatisticsTable.insertOnConflictUpdate(entity.companion);
  }

  Future _updateCount(
    String? packageName,
    String endpoint,
    EndpointType type,
    int addCountAllowed,
    int addSizeAllowed,
    int addCountBlocked,
    int addSizeBlocked,
    int timestamp,
  ) async {
    // insert entry if not exists
    if (await get(packageName, endpoint, type) == null) {
      await insert(
        TrafficStatistics(
          packageName: packageName,
          endpoint: endpoint,
          endpointType: type,
          packetCountAllowed: addCountAllowed,
          packetSizeAllowed: addSizeAllowed,
          packetCountBlocked: addCountBlocked,
          packetSizeBlocked: addSizeBlocked,
          latest: timestamp,
        ),
      );
      return;
    }

    // if entry exists, add values
    await (db.trafficStatisticsTable.update()..where(
          (t) =>
              t.packageName.equalsNullable(packageName) &
              t.endpoint.equals(endpoint) &
              t.endpointType.equalsValue(type) &
              t.latest.isBiggerThanValue(timestamp),
        ))
        .write(
          TrafficStatisticsTableCompanion.custom(
            packetCountAllowed: addInt(
              db.trafficStatisticsTable.packetCountAllowed,
              addCountAllowed,
            ),
            packetSizeAllowed: addInt(
              db.trafficStatisticsTable.packetSizeAllowed,
              addSizeAllowed,
            ),
            packetCountBlocked: addInt(
              db.trafficStatisticsTable.packetCountBlocked,
              addCountBlocked,
            ),
            packetSizeBlocked: addInt(
              db.trafficStatisticsTable.packetSizeBlocked,
              addSizeBlocked,
            ),
            latest: Variable(timestamp),
          ),
        );
  }

  @override
  Future<TrafficStatistics?> get(
    String? packageName,
    String endpoint,
    EndpointType type,
  ) async {
    return await (db.trafficStatisticsTable.select()
          ..where(
            (t) =>
                t.packageName.equalsNullable(packageName) &
                t.endpoint.equals(endpoint) &
                t.endpointType.equalsValue(type),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  Future<Set<String>> _getEndpointsForPackage(
    String? packageName,
    EndpointType endpointType,
  ) async {
    List<TypedResult> tmp =
        await (db.trafficStatisticsTable.selectOnly()
              ..addColumns([db.trafficStatisticsTable.endpoint])
              ..where(
                db.trafficStatisticsTable.endpointType.equalsValue(
                      endpointType,
                    ) &
                    db.trafficStatisticsTable.packageName.equalsNullable(
                      packageName,
                    ),
              ))
            .get();
    return tmp
        .map((e) => e.read(db.trafficStatisticsTable.endpoint))
        .nonNulls
        .toSet();
  }

  @override
  Future<Set<String>> getHostsForPackage(String? packageName) async {
    return await _getEndpointsForPackage(packageName, EndpointType.host);
  }

  @override
  Future<Set<String>> getIPsForPackage(String? packageName) async {
    return await _getEndpointsForPackage(packageName, EndpointType.ip);
  }

  @override
  Future<void> resetStatistics() async {
    await db.trafficStatisticsTable.update().write(
      TrafficStatisticsTableCompanion(
        packetCountAllowed: Value(0),
        packetSizeAllowed: Value(0),
        packetCountBlocked: Value(0),
        packetSizeBlocked: Value(0),
      ),
    );
  }

  @override
  Future addLog(TrafficLog log) async {
    await _updateCount(
      log.packageName,
      log.ip,
      EndpointType.ip,
      log.allowed ? 1 : 0,
      log.allowed ? log.size : 0,
      log.blocked ? 1 : 0,
      log.blocked ? log.size : 0,
      log.time,
    );
    if (log.host.empty) return;
    await _updateCount(
      log.packageName,
      log.host!,
      EndpointType.host,
      log.allowed ? 1 : 0,
      log.allowed ? log.size : 0,
      log.blocked ? 1 : 0,
      log.blocked ? log.size : 0,
      log.time,
    );
  }

  @override
  Future<SessionStatistics> getPackageStatistics(
    List<String> availablePackages,
  ) async {
    // get overall statistic count
    Expression<int> totalCountAllowed = db
        .trafficStatisticsTable
        .packetCountAllowed
        .sum();
    Expression<int> totalSizeAllowed = db
        .trafficStatisticsTable
        .packetSizeAllowed
        .sum();
    Expression<int> totalCountBlocked = db
        .trafficStatisticsTable
        .packetCountBlocked
        .sum();
    Expression<int> totalSizeBlocked = db
        .trafficStatisticsTable
        .packetSizeBlocked
        .sum();
    SessionStatistics statistics =
        await (db.trafficStatisticsTable.selectOnly()..addColumns([
              totalCountAllowed,
              totalSizeAllowed,
              totalCountBlocked,
              totalSizeBlocked,
            ]))
            .map(
              (r) => SessionStatistics(
                packetCountAllowed: r.read(totalCountAllowed) ?? 0,
                packetSizeAllowed: r.read(totalSizeAllowed) ?? 0,
                packetCountBlocked: r.read(totalCountBlocked) ?? 0,
                packetSizeBlocked: r.read(totalSizeBlocked) ?? 0,
              ),
            )
            .getSingleOrNull() ??
        SessionStatistics();

    // get package with most traffic count
    Expression<int> totalCount =
        (db.trafficStatisticsTable.packetCountAllowed +
                db.trafficStatisticsTable.packetCountBlocked)
            .sum();
    Expression<int> totalSize =
        (db.trafficStatisticsTable.packetSizeAllowed +
                db.trafficStatisticsTable.packetSizeBlocked)
            .sum();
    Expression<int> ipsCount = db.trafficStatisticsTable.endpoint.count(
      distinct: true,
      filter: db.trafficStatisticsTable.endpointType.equalsValue(
        EndpointType.ip,
      ),
    );
    Expression<int> hostsCount = db.trafficStatisticsTable.endpoint.count(
      distinct: true,
      filter: db.trafficStatisticsTable.endpointType.equalsValue(
        EndpointType.host,
      ),
    );
    statistics.mostTrafficPackage =
        (await (db.trafficStatisticsTable.selectOnly()
                  ..addColumns([
                    db.trafficStatisticsTable.packageName,
                    totalCountAllowed,
                    totalCountBlocked,
                    totalCount,
                    totalSizeAllowed,
                    totalSizeBlocked,
                    totalSize,
                    ipsCount,
                    hostsCount,
                  ])
                  ..groupBy([db.trafficStatisticsTable.packageName])
                  ..where(totalSize.isBiggerThanValue(0))
                  ..orderBy([
                    OrderingTerm(
                      expression: totalCount,
                      mode: OrderingMode.desc,
                    ),
                  ]))
                .map(
                  (r) => PackageStatistics(
                    packageName: r.read(db.trafficStatisticsTable.packageName),
                    packetCountAllowed: r.read(totalCountAllowed) ?? 0,
                    packetSizeAllowed: r.read(totalSizeAllowed) ?? 0,
                    packetCountBlocked: r.read(totalCountBlocked) ?? 0,
                    packetSizeBlocked: r.read(totalSizeBlocked) ?? 0,
                    ipsCount: r.read(ipsCount) ?? 0,
                    hostsCount: r.read(hostsCount) ?? 0,
                  ),
                )
                .get())
            .firstWhereOrNull((p) => availablePackages.contains(p));

    // get package with most blocked traffic count
    statistics.mostBlockedPackage =
        (await (db.trafficStatisticsTable.selectOnly()
                  ..addColumns([
                    db.trafficStatisticsTable.packageName,
                    totalCountAllowed,
                    totalCountBlocked,
                    totalCount,
                    totalSizeAllowed,
                    totalSizeBlocked,
                    ipsCount,
                    hostsCount,
                  ])
                  ..groupBy([db.trafficStatisticsTable.packageName])
                  ..where(totalCountBlocked.isBiggerThanValue(0))
                  ..orderBy([
                    OrderingTerm(
                      expression: totalCountBlocked,
                      mode: OrderingMode.desc,
                    ),
                  ]))
                .map(
                  (r) => PackageStatistics(
                    packageName: r.read(db.trafficStatisticsTable.packageName),
                    packetCountAllowed: r.read(totalCountAllowed) ?? 0,
                    packetSizeAllowed: r.read(totalSizeAllowed) ?? 0,
                    packetCountBlocked: r.read(totalCountBlocked) ?? 0,
                    packetSizeBlocked: r.read(totalSizeBlocked) ?? 0,
                    ipsCount: r.read(ipsCount) ?? 0,
                    hostsCount: r.read(hostsCount) ?? 0,
                  ),
                )
                .get())
            .firstWhereOrNull((p) => availablePackages.contains(p));
    return statistics;
  }
}
