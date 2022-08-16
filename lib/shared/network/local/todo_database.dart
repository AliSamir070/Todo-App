import 'dart:async';


import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TODODatabase{
  static Database? databaseInstance = null;
  static TODODatabase Instance = TODODatabase();
  Future<Database?> getInstance(List<Map> allTasks) async {
    if(databaseInstance !=null){
      return databaseInstance;
    }
    var database = await openDatabase(
        'todo,db',
        version: 1,
        onCreate: (database , version) async {
          try {
            print('Database created');
            await database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT , date TEXT, time TEXT, status TEXT)');
            print('Table created');
          } on Exception catch (e) {
            print("Error on creating tables: ${e.toString()}");
          }
        },
        onOpen: (database){
          print('Database opened');
        }
    );
    databaseInstance = database;
    print('Database returned');
    return databaseInstance;
  }
  Future<int> DeleteData(int id) async{
    return await databaseInstance!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
  }
  Future<int> UpdateData(String status , int id) async{
    return await databaseInstance!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]);
  }
  Future? insertToDatabase(String title , String date , String time) async{
    return await databaseInstance?.transaction((txn){
     return txn.rawInsert('INSERT INTO tasks (title, date, time, status) VALUES ("$title", "$date" , "$time" , "new")')
          .then((value){print('$value Inserted Successfully');}).catchError((onError){print("Error on inserting: ${onError.toString()}");});
    });
  }
  
  Future<List<Map<String, Object?>>> getAllTasks(Database? database) async {
    return await database!.rawQuery('SELECT * FROM tasks');
  }
}