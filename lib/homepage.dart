import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_firebase_bloc/addtask.dart';
import 'package:todo_firebase_bloc/task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      appBar: AppBar(
        backgroundColor: Color(0xff000000),
        centerTitle: true,
        title: const Text("To-Do List"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.calendar),
          ),
        ],
      ),
      extendBody: true,
      body: const Tasks(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfffe2121),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTaskAlertDialog();
            },
          );
        },
        child: const Icon(Icons.add,color: Color(0xffffffff),),
      ),
    );
  }
}
