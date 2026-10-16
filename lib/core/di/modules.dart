import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/app_database.dart';
import '../database/daos/memories_dao.dart';

@module
abstract class Modules {
  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();

  @lazySingleton
  MemoriesDao memoriesDao(AppDatabase db) => db.memoriesDao;
}
