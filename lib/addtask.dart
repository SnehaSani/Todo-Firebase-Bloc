import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddTaskAlertDialog extends StatefulWidget {
  const AddTaskAlertDialog({super.key});

  @override
  State<AddTaskAlertDialog> createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'New Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      content: SizedBox(
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: taskNameController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20,),
                  hintText: 'Task',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.square_list, color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                cursorColor: Colors.red,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.bubble_left_bubble_right, color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                cursorColor: Colors.red,
              ),
              const SizedBox(height: 15),
              // Row(
              //   children: <Widget>[
              //     const Icon(CupertinoIcons.tag, color: Colors.brown),
              //     const SizedBox(width: 15.0),
              //     Expanded(
              //       child: DropdownButtonFormField2(
              //         decoration: InputDecoration(
              //           isDense: true,
              //           contentPadding: EdgeInsets.zero,
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //         ),
              //         isExpanded: true,
              //         hint: const Text(
              //           'Add a task tag',
              //           style: TextStyle(fontSize: 14),
              //         ),
              //         // buttonHeight: 60,
              //         // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
              //         // dropdownDecoration: BoxDecoration(
              //         //   borderRadius: BorderRadius.circular(15),
              //         // ),
              //         // validator: (value) => value == null
              //         //     ? 'Please select the task tag' : null,
              //         items: taskTags.map((item) => DropdownMenuItem<String>(
              //             value: item,
              //             child: Text(
              //               item,
              //               style: const TextStyle(fontSize: 14,),
              //             ),
              //           ),
              //         ).toList(),
              //         onChanged: (String? value) => setState(() {
              //           if (value != null) selectedValue = value;
              //         },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final taskName = taskNameController.text;
            final taskDesc = taskDescController.text;
            _addTasks(taskName: taskName, taskDesc: taskDesc);
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future _addTasks({required String taskName, required String taskDesc}) async {
    DocumentReference docRef = await FirebaseFirestore.instance.collection('tasks').add(
      {
        'taskName': taskName,
        'taskDesc': taskDesc,
        'done': false,
      },
    );
    String taskId = docRef.id;
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update(
      {'id': taskId},
    );
    _clearAll();
  }

  void _clearAll() {
    taskNameController.text = '';
    taskDescController.text = '';
  }
}