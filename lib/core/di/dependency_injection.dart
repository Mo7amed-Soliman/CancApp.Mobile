import 'package:canc_app/core/helpers/database/cache_helper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupGetIt() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
}
