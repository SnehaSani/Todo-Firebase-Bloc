import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase_bloc/deletetask.dart';
import 'package:todo_firebase_bloc/updatetask.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: const Text('No tasks to display',style: TextStyle(color: Colors.white),));
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                return Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.grey,
                    //     blurRadius: 5.0,
                    //     offset: Offset(0, 5), // shadow direction: bottom right
                    //   ),
                    // ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(top: 10.0,left: 10,bottom: 10),
                    leading: Checkbox(
                      activeColor: Colors.red,
                      value: data['done'],
                      onChanged: (bool? newValue) {
                        setState(() async{
                          await FirebaseFirestore.instance.collection('tasks').doc(data['id']).update(
                            {'done': newValue!},
                          );
                        });
                      },
                    ),
                    title: Text(data['taskName'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    subtitle: Text(data['taskDesc']),
                    isThreeLine: true,
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'edit',
                            child: const Text(
                              'Edit',
                              style: TextStyle(fontSize: 13.0),
                            ),
                            onTap: () {
                              String taskId = (data['id']);
                              String taskName = (data['taskName']);
                              String taskDesc = (data['taskDesc']);
                              Future.delayed(
                                const Duration(seconds: 0),
                                    () => showDialog(context: context, builder: (context) =>
                                        UpdateTaskAlertDialog(taskId: taskId, taskName: taskName, taskDesc: taskDesc),
                                ),
                              );
                            },
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: const Text(
                              'Delete',
                              style: TextStyle(fontSize: 13.0),
                            ),
                            onTap: (){
                              String taskId = (data['id']);
                              String taskName = (data['taskName']);
                              Future.delayed(
                                const Duration(seconds: 0),
                                    () => showDialog(
                                  context: context,
                                  builder: (context) => DeleteTaskDialog(taskId: taskId, taskName:taskName),
                                ),
                              );
                            },
                          ),
                        ];
                      },
                    ),
                    dense: true,
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}