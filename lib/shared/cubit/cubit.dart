import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tudu/shared/cubit/states.dart';
import '../../screens/Archived.dart';
import '../../screens/Done.dart';
import '../../screens/New.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  // Bottom NavBar State
  var currentIndex = 0;
  List<Widget> screens =
  [
    New(),
    Done(),
    Archived(),
  ];

  void ChangeIndex(int index) {
    currentIndex = index;
   emit(bottomNavBarState());
  }

  // BottomSheet
  void changeBottomSheetState(
      {
        required bool IsShow,
        required IconData icon,
      })
  {
    isBottomSheetShown = IsShow;
    FabIcon = icon;
    emit(BottomSheetChangeState());
  }

  // Database

  Database? database;
  List<Map> NewTasks = [];
  List<Map> DoneTasks = [];
  List<Map> ArchivedTasks = [];
  bool isBottomSheetShown = false;
  IconData FabIcon = Icons.edit;

  // Create Database
  void createDatabase()  {
    openDatabase('todo.db', version: 1,
        onCreate: (database, version)
        {
          print('database created');
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('error while creating table ${error.toString()}');
          });
        }, onOpen: (database) {
          getDatabase(database);
          print('database opened');
        }).then((value)
    {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  // Insert Database
  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async
  {
    return await database!.transaction(
          (txn) => txn.rawInsert(
          'INSERT INTO tasks (title, time, date, status ) VALUES("$title", "$time", "$date", "new")'
      ).then((value)
      {
        print('$value inserted successfully');
        emit(AppInsertToDatabaseState());
        getDatabase(database);
      }),);
  }

  // GetFrom Database
  void getDatabase(database)
  {
    NewTasks = [];
    DoneTasks = [];
    ArchivedTasks = [];
    database!.rawQuery('SELECT * FROM tasks').then((value)
    {
      value.forEach((element)
      {

        if(element['status'] == 'Archived') NewTasks.add(element);

        else if(element['status'] == 'Done') DoneTasks.add(element);

        else ArchivedTasks.add(element);

      });
      emit(AppGetFromDatabaseState());
    },);
  }

  // Update Database
  void UpdateDatabase({
    required String status,
    required int id,

  }) async
  {
    database!.rawUpdate
      (
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id,]
    ).then((value)
    {
      getDatabase(database);
      emit(AppUpdateDatabaseState());
    });



  }


  // Delete Database
  void DeleteDatabase({
    required int id,
  }) async
  {
    database!.rawDelete
      (
        'DELETE FROM tasks WHERE id = ?', [id],
    ).then((value)
    {
      getDatabase(database);
      emit(AppDeleteDatabaseState());
    });



  }

}