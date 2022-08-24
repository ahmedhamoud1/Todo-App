import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/cubit.dart';

Widget BuildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction)
  {
    AppCubit.get(context).DeleteDatabase(id: model['id']);
  },
  child:  Column(

    children: [

      Padding(

        padding: const EdgeInsets.only(

          bottom: 10,

          left: 15,

          right: 20,

          top: 10,

        ),

        child: Container(

          width: double.infinity,

          decoration: BoxDecoration(

              color: Color(0xff517fe7),

              borderRadius: BorderRadius.circular(16)),

          child: Padding(

            padding: const EdgeInsets.all(8.0),

            child: Row(

              children: [

                CircleAvatar(

                  radius: 42,

                  child: Text(

                    '${model['time']}',

                    style:

                    GoogleFonts.acme(color: Colors.white, fontSize: 19),

                  ),

                  backgroundColor: Color(

                    0xff517fe7,

                  ),

                ),

                SizedBox(

                  width: 20,

                ),

                Expanded(

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisSize: MainAxisSize.min,

                    children: [

                      Text(

                        '${model['title']}',

                        style: GoogleFonts.acme(

                            color: Colors.white, fontSize: 20),

                      ),

                      SizedBox(

                        height: 10,

                      ),

                      Text(

                        '${model['date']}',

                        style: GoogleFonts.acme(

                            color: Colors.white.withOpacity(0.98),

                            fontSize: 18),

                      ),

                    ],

                  ),

                ),

                SizedBox(

                  width: 5,

                ),

                IconButton(

                  onPressed: () {

                    AppCubit.get(context).UpdateDatabase(

                      status: 'Done',

                      id: model['id'],

                    );

                  },

                  icon: Icon(

                    Icons.check_box_outlined,

                    color: Colors.white,

                    size: 30,

                  ),

                ),

                IconButton(

                    onPressed: () {

                      AppCubit.get(context).UpdateDatabase(

                        status: 'Archived',

                        id: model['id'],

                      );

                    },

                    icon: Icon(Icons.archive_outlined,

                        color: Colors.white, size: 30)),

              ],

            ),

          ),

        ),

      )

    ],

  ),
);


Widget TasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => ListView.separated(
          itemCount: tasks.length,
          itemBuilder: (context, index) => BuildTaskItem(tasks[index], context),
          separatorBuilder: (context, index) => SizedBox(),
        ),
    fallback: (BuildContext context) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/1.png')),
          ),
        ));