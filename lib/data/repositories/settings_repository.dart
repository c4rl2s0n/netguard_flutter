import 'package:drift/drift.dart';
import 'package:netguard/data/data.dart';

class SettingsRepository extends ISettingsRepository {
  @override
  Future<Settings> get() async {
    List<Settings> settings = await (db.settingsTable.select()..limit(1)).get();
    return settings.firstOrNull ?? Settings();
  }

  @override
  Future<void> update(Settings settings) async {
    await db.settingsTable.insertOnConflictUpdate(settings.companion);
  }
}
