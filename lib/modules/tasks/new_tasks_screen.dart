import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/shared/components/components.dart';
import 'package:test_app/shared/cubit/states.dart';
import 'package:test_app/shared/network/local/todo_database.dart';

import '../../shared/cubit/cubit.dart';

class NewTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
        builder: (context , states){
          var tasks = AppCubit.get(context).newTasks;
          return tasks.isEmpty?errorMessage():ListView.separated(
              itemBuilder: (context , item){
                return taskItem(model: tasks[item]);
              },
              separatorBuilder: (context,item)=>Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 1,
                ),
              ),
              itemCount: tasks.length);},
        listener: (context , states){}
    );
  }
}

