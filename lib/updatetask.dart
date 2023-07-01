import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UpdateTaskAlertDialog extends StatefulWidget {
  final String taskId, taskName, taskDesc;

  const UpdateTaskAlertDialog(
      {Key? Key, required this.taskId, required this.taskName, required this.taskDesc})
      : super(key: Key);

  @override
  State<UpdateTaskAlertDialog> createState() => _UpdateTaskAlertDialogState();
}

class _UpdateTaskAlertDialogState extends State<UpdateTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    taskNameController.text = widget.taskName;
    taskDescController.text = widget.taskDesc;

    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Update Task',
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
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
                  // Expanded(
                  //   child: DropdownButtonFormField2(
                  //     decoration: InputDecoration(
                  //       isDense: true,
                  //       contentPadding: EdgeInsets.zero,
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(15),
                  //       ),
                  //     ),
                  //     isExpanded: true,
                  //     value: widget.taskTag,
                      // buttonHeight: 60,
                      // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      // dropdownDecoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                  //     items: taskTags
                  //         .map(
                  //           (item) => DropdownMenuItem<String>(
                  //         value: item,
                  //         child: Text(
                  //           item,
                  //           style: const TextStyle(
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //         .toList(),
                  //     onChanged: (String? value) => setState(
                  //           () {
                  //         if (value != null) selectedValue = value;
                  //       },
                  //     ),
                  //   ),
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
            _updateTasks(taskName, taskDesc);
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: const Text('Update'),
        ),
      ],
    );
  }

  Future _updateTasks(String taskName, String taskDesc) async {
    var collection = FirebaseFirestore.instance.collection('tasks');
    collection.doc(widget.taskId).update({
      'taskName': taskName, 'taskDesc': taskDesc
    }).then(
          (_) => Fluttertoast.showToast(
          msg: "Task updated successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0),
    )
        .catchError(
          (error) => Fluttertoast.showToast(
          msg: "Failed: $error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0),
    );
  }
}