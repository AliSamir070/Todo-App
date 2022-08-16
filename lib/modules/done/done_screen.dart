import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
        builder: (context , states){
          var tasks = AppCubit.get(context).doneTasks;
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
