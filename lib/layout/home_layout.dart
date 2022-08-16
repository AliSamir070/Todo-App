import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_app/modules/archived/archived_screen.dart';
import 'package:test_app/modules/done/done_screen.dart';
import 'package:test_app/modules/tasks/new_tasks_screen.dart';
import 'package:test_app/shared/components/components.dart';
import 'package:test_app/shared/cubit/cubit.dart';
import 'package:test_app/shared/cubit/states.dart';
import 'package:test_app/shared/network/local/todo_database.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit , AppStates>(
        builder: (context , state){
          AppCubit tempCubit = AppCubit.get(context);
          return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(tempCubit.currentAppBarTitle[tempCubit.currentIndex]),
          ),
          body: state is AppGetDatabaseLoadingState
              ? Center(child: CircularProgressIndicator())
              : tempCubit.currentScreen[tempCubit.currentIndex],
          floatingActionButton: FloatingActionButton(

              onPressed: () {
                if (tempCubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    tempCubit.insertIntoDatabase(
                        titleController.text,
                        dateController.text,
                        timeController.text
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                          (context) => Container(
                        padding: EdgeInsetsDirectional.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DefaultFormField(
                                  controller: titleController,
                                  text: "Title",
                                  type: TextInputType.text,
                                  Prefix: Icon(Icons.title),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Title mustn't be empty";
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              DefaultFormField(
                                  controller: timeController,
                                  text: "Time",
                                  type: TextInputType.datetime,
                                  isCursorShowed: false,
                                  isReadable: true,
                                  onTap: () async {
                                    var date = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());
                                    timeController.text =
                                        date!.format(context);
                                  },
                                  Prefix: Icon(Icons.watch_later_outlined),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "time mustn't be empty";
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              DefaultFormField(
                                  controller: dateController,
                                  text: "Date",
                                  type: TextInputType.datetime,
                                  isCursorShowed: false,
                                  isReadable: true,
                                  onTap: () async {
                                    var date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate:
                                        DateTime.parse("2022-08-18"));
                                    dateController.text =
                                        DateFormat.yMMMd().format(date!);
                                  },
                                  Prefix: Icon(Icons.watch_later_outlined),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "date mustn't be empty";
                                    }
                                    return null;
                                  }),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(20),
                              topEnd: Radius.circular(20))))
                      .closed
                      .then((value) {
                      tempCubit.changeBottom(false);
                  });
                  tempCubit.changeBottom(true);
                }
              },
              child: Icon((tempCubit.isBottomSheetShown) ? Icons.add : Icons.edit)),
          bottomNavigationBar: BottomNavigationBar(

              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.blue,
              currentIndex: tempCubit.currentIndex,
              onTap: (index) {
               tempCubit.setBottomNavIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "Archived"),
              ]),
        );},
        listener: (context , state){
          if(state is AppInsertIntoDatabaseState){
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
