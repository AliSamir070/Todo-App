import 'package:flutter/material.dart';
import 'package:test_app/modules/archived/archived_screen.dart';
import 'package:test_app/modules/done/done_screen.dart';
import 'package:test_app/modules/tasks/new_tasks_screen.dart';
import 'package:test_app/shared/components/components.dart';
import 'package:test_app/shared/network/local/todo_database.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;
  List<Widget> currentScreen = [NewTasksScreen() , DoneScreen(), ArchivedScreen()];
  List<String> currentAppBarTitle = ['New Tasks' , 'Done' , 'Archived'];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TODODatabase.Instance.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          currentAppBarTitle[_currentIndex]
        ),
      ),
      body: currentScreen[_currentIndex],
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if(isBottomSheetShown){
              Navigator.pop(context);
              isBottomSheetShown = false;
              setState((){

              });
            }else{
              scaffoldKey.currentState?.showBottomSheet((context) => Container(
                color: Colors.grey[200],
                padding: EdgeInsetsDirectional.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultFormField(
                        controller: titleController,
                        text: "Title",
                        type: TextInputType.text,
                        Prefix: Icon(
                            Icons.title
                        ),
                        validator: (value){
                          if(value!.isEmpty){
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
                        onTap: () async {
                          var date = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now()
                          );
                          print("Date Time: ${date?.format(context)}");
                        },
                        Prefix: Icon(
                            Icons.watch_later_outlined
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "time mustn't be empty";
                          }
                          return null;
                        }),
                  ],
                ),
              ));
              isBottomSheetShown = true;
              setState((){

              });
            }
          },
          child: Icon(
              (isBottomSheetShown)?Icons.add:Icons.edit
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.blue,
          currentIndex: _currentIndex,
          onTap: (index){
            setState((){
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "Tasks",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                label: "Done"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                label: "Archived"
            ),
          ]
      ),
    );
  }
  Future<String> getName() async{
    return "Ali Samir";
  }
}
