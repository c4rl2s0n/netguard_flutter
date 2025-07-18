import 'package:netguard/common/service_locator/service_locator.dart';
import 'package:netguard/data/data.dart';

class RepositoryBase {
  final AppDatabase db = getIt<AppDatabase>();
}
