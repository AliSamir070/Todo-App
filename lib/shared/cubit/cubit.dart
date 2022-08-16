import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/shared/cubit/states.dart';
import 'package:test_app/shared/network/local/todo_database.dart';

import '../../modules/archived/archived_screen.dart';
import '../../modules/done/done_screen.dart';
import '../../modules/tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool isBottomSheetShown = false;
  List<Widget> currentScreen = [
    NewTasksScreen(),
    DoneScreen(),
    ArchivedScreen()
  ];
  List<String> currentAppBarTitle = ['New Tasks', 'Done', 'Archived'];

  void setBottomNavIndex(int index){
    currentIndex = index;
    emit(AppBottomNavState());
  }
  void createDatabase(){
    TODODatabase.Instance.getInstance(newTasks).then((value){
      emit(AppCreateDatabaseState());
      getDatabase(value);
    });
  }
  void updateStatusDatabase(String status , int id){
    TODODatabase.Instance.UpdateData(status, id).then((value) =>  emit(AppUpdateDataInDatabaseState()));
  }
  void getDatabase(Database? database){
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    TODODatabase.Instance.getAllTasks(database).then((value){
      emit(AppGetDatabaseState());
      value.forEach((element) {
        if(element['status'] == 'new'){
          newTasks.add(element);
        }else if(element['status'] == 'done'){
          doneTasks.add(element);
        }else if(element['status'] == 'archive'){
          archivedTasks.add(element);
        }
      });
    });

  }
  void deleteFromDatabase(int id){
    TODODatabase.Instance.DeleteData(id).then(
            (value) {
          emit(AppDeleteDataInDatabaseState());
          getDatabase(TODODatabase.databaseInstance);
        });
  }
  void insertIntoDatabase(String title,String date , String time){
    TODODatabase.Instance.insertToDatabase(title, date, time)?.then(
            (value){
              emit(AppInsertIntoDatabaseState());
              getDatabase(TODODatabase.databaseInstance);
            }
    );
  }
  void changeBottom(bool isShow){
    isBottomSheetShown = isShow;
    emit(AppChangeBottomState());
  }
}