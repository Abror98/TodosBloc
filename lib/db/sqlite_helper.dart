
import 'dart:io';

import 'package:bloc_sample/model/mymodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  final _databaseName = "task.db";
  final _databaseVersion = 1;
  final mytable = 'mytable';
  final columId = 'id';
  final columnName = 'name';
  final columnDate = 'date';
  final columnStatus = 'status';


  static final DatabaseHelper _instance = DatabaseHelper.internal();
  Database _database;
  DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, _databaseName);

    // SQL code to create the database table
    var db = await openDatabase(path, version: _databaseVersion, onCreate: onCreate);
    return db;
  }

  void  onCreate (Database db, int version) async {
    await db.execute('''
          CREATE TABLE $mytable (
             $columId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT,
            $columnDate TEXT,
            $columnStatus TEXT
          )
          ''');
  }

  Future<int> insert(@required MyModel info) async {
    final db = await database;
    var res = await db.insert(mytable, info.toJson());
    return res;
  }

  Future update(@required MyModel info, @required MyModel oldinfo) async {
    final db = await database;
    var res = await db.rawQuery('UPDATE $mytable SET $columnName = "${info.name}", $columnDate = "${info.date}", $columnStatus = "${info.status}" WHERE $columnName = "${oldinfo.name}" AND $columnDate = "${oldinfo.date}" AND $columnStatus = "${oldinfo.status}"');
    return res;
  }

  Future removeItem(String name, String day, String status) async{
    final db = await database;
    var res =  db.rawQuery('DELETE from $mytable WHERE $columnName = "$name" AND $columnDate = "$day" AND $columnStatus = "$status"');
    return res;
  }

  Future<List<MyModel>>  getAllUserInfo(int id) async {
    var dbClient = await database;
    List<Map> list = [];
    if(id == 1)
    list = await dbClient.rawQuery('select *from $mytable');
    else if(id == 2)
    list = await dbClient.rawQuery(
        'select *from $mytable WHERE $columnStatus = "в прогрессе"');
    else
    list = await dbClient.rawQuery(
        'select *from $mytable WHERE $columnStatus = "выполнено"');
    List<MyModel> note = [];
    list.forEach((it) =>
        note.add(MyModel(
            name: it["name"],
            date: it["date"],
            status: it["status"])));
    return note;
  }

  Future clearTable() async {
    var db = await database;
    return await db.rawQuery("DELETE FROM $mytable");
  }


  Future close() async {
    var dbClient = await database;
    dbClient.close();
  }

}