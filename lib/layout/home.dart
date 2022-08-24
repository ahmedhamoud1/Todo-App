import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tudu/shared/cubit/cubit.dart';
import 'package:tudu/shared/cubit/states.dart';

class Home extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state)
        {
          if (state is AppInsertToDatabaseState)
          {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, Object? state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.scatter_plot,
                  size: 28,
                  color: Color(0xff517fe7),
                ),
              ),
            ),
            drawer: Drawer(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('images/2.png'),
                    ),
                  ),
                  Text(
                    'For technical support \ncontact us \n \n'
                    '+201013477060',
                    style: GoogleFonts.acme(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Color(0xff517fe7),
              index: cubit.currentIndex,
              height: 48,
              onTap: (index)
              {
                cubit.ChangeIndex(index);
              },
              items: [
                Icon(
                  Icons.list,
                  color: Color(0xff517fe7),
                  size: 25,
                ),
                Icon(
                  Icons.check_circle_outlined,
                  color: Color(0xff517fe7),
                  size: 25,
                ),
                Icon(
                  Icons.archive_outlined,
                  color: Color(0xff517fe7),
                  size: 25,
                ),
              ],
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
                right: 10,
              ),
              child: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                      );
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                        elevation: 5,
                            (context) => Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            left: 10,
                            bottom: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Form(
                              key: formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      onTap: () {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'INVALID DATA';
                                        }
                                      },
                                      controller: titleController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  16)),
                                          prefixIcon: Icon(Icons.title),
                                          labelText: 'Task Title',
                                          labelStyle:
                                          TextStyle(fontSize: 19)),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          timeController.text =
                                              value!.format(context);
                                        }).catchError((error) {
                                          print(
                                              'error in show time picker ${error.toString()}');
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'INVALID DATA';
                                        }
                                      },
                                      controller: timeController,
                                      keyboardType:
                                      TextInputType.datetime,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  16)),
                                          prefixIcon: Icon(Icons
                                              .watch_later_outlined),
                                          labelText: 'Task Time',
                                          labelStyle:
                                          TextStyle(fontSize: 19)),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse(
                                              '5000-01-01'),
                                        ).then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd()
                                                  .format(value!);
                                        }).catchError((error) {
                                          print(
                                              'error in show date picker ${error.toString()}');
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'INVALID DATA';
                                        }
                                      },
                                      controller: dateController,
                                      keyboardType:
                                      TextInputType.datetime,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  16)),
                                          prefixIcon: Icon(
                                              Icons.calendar_today),
                                          labelText: 'Task Date',
                                          labelStyle:
                                          TextStyle(fontSize: 19)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState(
                        icon: Icons.edit,
                        IsShow: false,
                      );
                    });

                    cubit.changeBottomSheetState(
                      icon: Icons.add,
                      IsShow: true,
                    );
                  }
                },
                backgroundColor: Color(0xff517fe7),
                elevation: 5,
                child: Icon(
                  cubit.FabIcon,
                  size: 29,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
