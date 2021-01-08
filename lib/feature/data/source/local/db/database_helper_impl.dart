import 'package:sqflite/sqflite.dart';
import 'package:tinggal_makan_app/core/error/exception.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_entity.dart';
import 'package:tinggal_makan_app/feature/data/source/local/db/database_helper.dart';

class DatabaseHelperImpl implements DatabaseHelper {
  static DatabaseHelperImpl _databaseHelper;
  static Database _database;
  static String _tableName = 'restaurant_table';
  static String _dbName = 'restaurant_db.db';

  DatabaseHelperImpl._createObject();

  factory DatabaseHelperImpl() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelperImpl._createObject();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/$_dbName', onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE $_tableName(
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      pictureId TEXT,
      city TEXT,
      rating DOUBLE)''',
      );
    }, version: 1);

    return db;
  }

  @override
  Future<void> insertRestaurant(RestaurantEntity restaurantEntity) async {
    try {
      final Database db = await database;
      db.insert(_tableName, restaurantEntity.toJson());
      print('Data saved');
    } catch (e) {
      print('Data not saved');
      throw CacheException();
    }
  }

  @override
  Future<List<RestaurantEntity>> getRestaurants() async {
    try {
      final Database db = await database;
      List<Map<String, dynamic>> result = await db.query(_tableName);
      return result.map((res) => RestaurantEntity.fromJson(res)).toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<RestaurantEntity> getRestaurantById(String id) async {
    try {
      final Database db = await database;
      List<Map<String, dynamic>> result =
          await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
      print('getRestaurantById success');
      return result.map((res) => RestaurantEntity.fromJson(res)).first;
    } catch (e) {
      print('getRestaurantById '  + e.toString());
      print('getRestaurantById failed' );
      throw CacheException();
    }
  }

  @override
  Future<void> deleteRestaurant(String id) async {
    try {
      final db = await database;
      await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
      print('Restaurant deleted');
    } catch (e) {
      print('Failed deleted');
      throw CacheException();
    }
  }
}
