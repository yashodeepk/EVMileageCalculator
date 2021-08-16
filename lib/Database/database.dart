import 'package:mileagecalculator/Database/datamodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

var trip_name;
var start_km;
var start_charge_percentage;
var batteryCapacity;
var batteryCap;
var electricityPrice;
var petrolPrize;
var petrolVehicalMileage;
var selectcurrency;
var totalDistance;
var distanceUnit;
var usedYears;

class DB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "Trip.db"),
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE TRIPTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          distance TEXT NOT NULL,
          savecharging TEXT NOT NULL,
          electricity TEXT NOT NULL,
          petrol TEXT NOT NULL,
          dateTimeadd TEXT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertData(DataModel dataModel) async {
    final Database db = await initDB();
    db.insert("TRIPTable", dataModel.tomap());
    return true;
  }

  Future<List<DataModel>> getData() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> datas = await db.query("TRIPTable");
    return datas.map((e) => DataModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    final Database db = await initDB();
    return await db.delete("TRIPTable", where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final Database db = await initDB();
    await db.delete("TRIPTable");
  }
}
