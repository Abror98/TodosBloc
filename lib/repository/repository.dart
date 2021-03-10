

import 'package:bloc_sample/db/sqlite_helper.dart';
import 'package:bloc_sample/model/mymodel.dart';

class DataRepository{
 static const TIME = 10;
  DatabaseHelper databaseHelper = DatabaseHelper();

   Future<List<MyModel>> databaseItems(int id) => databaseHelper.getAllUserInfo(id).timeout(Duration(seconds: TIME));

   Future<int> insertItems(MyModel myModel) => databaseHelper.insert(myModel).timeout(Duration(seconds: TIME));

   Future clearTable() => databaseHelper.clearTable().timeout(Duration(seconds: TIME));

  Future deleteId(String name, String date, String status) => databaseHelper.removeItem(name, date, status).timeout(Duration(seconds: TIME));

 Future updateItems(MyModel myModel, MyModel oldModel) => databaseHelper.update(myModel, oldModel).timeout(Duration(seconds: TIME));

 Future<List<MyModel>> databaseOrderDate(int id, String order) => databaseHelper.getAllUserOrderDate(id, order).timeout(Duration(seconds: TIME));

}