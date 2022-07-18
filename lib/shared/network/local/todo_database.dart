import 'package:sqflite/sqflite.dart';

class TODODatabase{
  static Database? databaseInstance = null;
  static TODODatabase Instance = TODODatabase();

  Future<Database?> getInstance() async {
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

  void insertToDatabase(String title , String date , String time , String status){
    databaseInstance?.transaction((txn){
     return txn.rawInsert('INSERT INTO tasks (title, date, time, status) VALUES ("$title", "$date" , "$time" , "$status")')
          .then((value){print('$value Inserted Successfully');}).catchError((onError){print("Error on inserting: ${onError.toString()}");});
    });
  }
}