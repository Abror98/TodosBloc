// To parse this JSON data, do
//
//     final myModel = myModelFromJson(jsonString);

import 'dart:convert';

List<MyModel> myModelFromJson(String str) => List<MyModel>.from(json.decode(str).map((x) => MyModel.fromJson(x)));

String myModelToJson(List<MyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyModel {
  MyModel({
    this.name,
    this.date,
    this.status,
  });

  String name;
  String date;
  String status;

  factory MyModel.fromJson(Map<String, dynamic> json) => MyModel(
    name: json["name"],
    date: json["date"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "date": date,
    "status": status,
  };
}
