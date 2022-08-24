import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class New extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          List<Map> tasks = AppCubit.get(context).ArchivedTasks;
          return TasksBuilder(tasks: tasks);
        },
        listener: (context, state) {});
  }
}
