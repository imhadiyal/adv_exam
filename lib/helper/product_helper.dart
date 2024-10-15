import 'package:logger/logger.dart';
import 'package:post_api_app/modals.dart';
import 'package:sqflite/sqflite.dart';

enum UserTable { name, category, price }

class DbHelper {
  DbHelper._();
  static final DbHelper dbHelper = DbHelper._();
  String dbName = "product.db";
  String tableName = "Users";
  late Database database;
  Logger logger = Logger();
  Future<void> initDb() async {
    // Path
    String dbPath = await getDatabasesPath();

    database = await openDatabase(
      '$dbPath/$dbName',
      // version
      version: 1,
      onCreate: (db, version) {
        String createTableQuery =
            """ CREATE TABLE IF NOT EXISTS $tableName (${UserTable.name.name} INTEGER PRIMARY KEY AUTOINCREMENT, ${UserTable.category.name} TEXT NOT NULL,${UserTable.price.name} TEXT NOT NULL);""";

        db
            .execute(createTableQuery)
            .then((value) => logger.i('table created'))
            .onError((error, stackTrace) => logger.e('ERROR: $error'));
      }, // onCreate

      onUpgrade: (db, v1, v2) {}, // onUpgrade
      onDowngrade: (db, v1, v2) {}, // onDowngrade
    ); // openDatabase
  }

  Future<void> insertData({required Product product}) async {
    String sql =
        "INSERT INTO $tableName(${UserTable.name.name},${UserTable.category.name},${UserTable.price.name}) VALUES (?,?,?);";
    // Map<String, dynamic> usermap = user.toJson();
    // usermap.remove('id');
    // await database.insert(tableName, usermap);

    await database
        .rawInsert(
          sql,
          [
            product.title,
            product.price,
            product.category,
          ],
        )
        .then(
          (value) => logger.i("user${product.title}"),
        )
        .onError(
          (error, stackTrace) => logger.e("error$error"),
        );
  }

  Future<void> updateData({required Product product}) async {
    Map<String, dynamic> userMap = product.toJson();
    await database
        .update(tableName, userMap)
        .then(
          (value) => logger.i('User ${product.title} updated !!'),
        )
        .onError(
          (error, stackTrace) => logger.e('Update Error: $error'),
        );
  }

  Future<void> deleteData({required Product product}) async {
    await database
        .delete(
          tableName,
          where: '${UserTable.name.name} = ?',
          whereArgs: [product.id],
        )
        .then(
          (value) => logger.i('Student ${product.title} deleted !!'),
        )
        .onError(
          (error, stackTrace) => logger.e('Delete Error: $error'),
        );
  }

  Future<List<Product>> getAllData() async {
    List<Map<String, dynamic>> allData =
        await database.rawQuery('SELECT * FROM $tableName');

    return allData
        .map(
          (e) => Product.fromJson(
            json: e,
          ),
        )
        .toList();
  }
}
