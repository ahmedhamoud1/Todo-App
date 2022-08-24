import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tudu/layout/splash.dart';
import 'package:tudu/shared/bloc_observer.dart';

void main()
{
  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
