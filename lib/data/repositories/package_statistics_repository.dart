import 'package:collection/collection.dart';
import 'package:netguard/netguard.dart';
import 'package:drift/drift.dart';

class PackageStatisticsRepository extends IPackageStatisticsRepository {
  PackageStatisticsRepository(super.db);

  @override
  Future<List<PackageStatistics>> getAll() async {
    return await (db.packageStatisticsTable.select()).get();
  }

  @override
  Future insert(PackageStatistics entity) async {
    await db.packageStatisticsTable.insertOnConflictUpdate(entity.companion);
  }

  @override
  Future updateCount(
    String packageName,
    int addCountAllowed,
    int addSizeAllowed,
    int addCountBlocked,
    int addSizeBlocked,
  ) async {
    // insert package if not exists
    if (await get(packageName) == null) {
      await insert(
        PackageStatistics(
          packageName: packageName,
          packetCountAllowed: addCountAllowed,
          packetSizeAllowed: addSizeAllowed,
          packetCountBlocked: addCountBlocked,
          packetSizeBlocked: addSizeBlocked,
        ),
      );
      return;
    }

    // if package exists, add values
    await (db.packageStatisticsTable.update()
          ..where((t) => t.packageName.equals(packageName)))
        .write(
          PackageStatisticsTableCompanion.custom(
            packetCountAllowed: addInt(
              db.packageStatisticsTable.packetCountAllowed,
              addCountAllowed,
            ),
            packetSizeAllowed: addInt(
              db.packageStatisticsTable.packetSizeAllowed,
              addSizeAllowed,
            ),
            packetCountBlocked: addInt(
              db.packageStatisticsTable.packetCountBlocked,
              addCountBlocked,
            ),
            packetSizeBlocked: addInt(
              db.packageStatisticsTable.packetSizeBlocked,
              addSizeBlocked,
            ),
          ),
        );
  }

  @override
  Future<PackageStatistics?> get(String packageName) async {
    return await (db.packageStatisticsTable.select()
          ..where((t) => t.packageName.equals(packageName))
          ..limit(1))
        .getSingleOrNull();
  }

  @override
  Future<SessionStatistics> getOverallStatistics(
    List<String> availablePackages,
  ) async {
    // get overall statistic count
    Expression<int> totalCountAllowed = db
        .packageStatisticsTable
        .packetCountAllowed
        .sum();
    Expression<int> totalSizeAllowed = db
        .packageStatisticsTable
        .packetSizeAllowed
        .sum();
    Expression<int> totalCountBlocked = db
        .packageStatisticsTable
        .packetCountBlocked
        .sum();
    Expression<int> totalSizeBlocked = db
        .packageStatisticsTable
        .packetSizeBlocked
        .sum();
    SessionStatistics statistics =
        await (db.packageStatisticsTable.selectOnly()..addColumns([
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
        db.packageStatisticsTable.packetCountAllowed +
        db.packageStatisticsTable.packetCountBlocked;
    statistics.mostTrafficPackage =
        (await (db.packageStatisticsTable.select()
                  ..addColumns([totalCount])
                  ..orderBy([
                    (t) => OrderingTerm(
                      expression: totalCount,
                      mode: OrderingMode.desc,
                    ),
                  ]))
                .get())
            .firstWhereOrNull((p) => availablePackages.contains(p.packageName))
            ?.packageName;

    // get package with most blocked traffic count
    statistics.mostBlockedPackage =
        (await (db.packageStatisticsTable.select()..orderBy([
                  (t) => OrderingTerm(
                    expression: t.packetCountBlocked,
                    mode: OrderingMode.desc,
                  ),
                ]))
                .get())
            .firstWhereOrNull((p) => availablePackages.contains(p.packageName))
            ?.packageName;
    return statistics;
  }

  @override
  Future<void> resetStatistics() async {
    await db.packageStatisticsTable.update().write(
      PackageStatisticsTableCompanion(
        packetCountAllowed: Value(0),
        packetSizeAllowed: Value(0),
        packetCountBlocked: Value(0),
        packetSizeBlocked: Value(0),
      ),
    );
  }

  @override
  Future addLog(TrafficLog log) async {
    if (log.packageName.empty) return;
    await updateCount(
      log.packageName!,
      log.allowed ? 1 : 0,
      log.allowed ? log.size : 0,
      log.blocked ? 1 : 0,
      log.blocked ? log.size : 0,
    );
  }
}
