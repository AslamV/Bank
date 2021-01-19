import 'dart:io';
import 'dart:async';
import 'package:bank/models/customer_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelp;
  static Database _databas;

  String custTable = 'customer';
  String colAccNo = 'account_no';
  String colCustName = 'cust_name';
  String colCustAddr = 'cust_addr';
  String colPhoneNo = 'phone_no';
  String colBal = 'bal';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelp == null) {
      _databaseHelp = DatabaseHelper._createInstance();
    }
    return _databaseHelp;
  }

  Future<Database> get database async {
    if (_databas == null) {
      _databas = await initializeDatabase();
    }
    return _databas;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'customer.db';
    var diaryDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return diaryDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    String sql =
        "CREATE TABLE $custTable($colAccNo INTEGER PRIMARY KEY ,$colCustName TEXT,$colCustAddr TEXT,$colPhoneNo INTEGER,$colBal DOUBLE)";
    await db.execute(sql);
  }

  Future<List<CustomerData>> getCustomerDataMapList() async {
    Database db = await this.database;
    List<CustomerData> cData = [];
    var result = await db.query(custTable);
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        cData.add(CustomerData.fromMapObject(result[i]));
      }
    }
    return cData;
  }

  Future<int> insertData(CustomerData data) async {
    Database db = await this.database;
    Map mp = data.toMap();
    print(mp);
    var result;
    try {
      result = await db.insert(custTable, mp);
    } catch (e) {
      return -1;
    }
    return result;
  }

  updateCustomer(CustomerData data) async {
    final db = await database;
    var res = await db.update(custTable, data.toMap(),
        where: "$colAccNo = ?", whereArgs: [data.accountNo]);
    return res;
  }

  getClient(int accno) async {
    final db = await database;
    var res =
        await db.query(custTable, where: "$colAccNo = ?", whereArgs: [accno]);
    return res.isNotEmpty ? CustomerData.fromMapObject(res.first) : Null;
  }
}
