import 'package:netguard/data/data.dart';

import 'repository_base.dart';

abstract class ISettingsRepository extends RepositoryBase {
  ISettingsRepository(super.db);

  Future<Settings> get();
  Future<void> update(Settings settings);
}
