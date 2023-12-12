import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:learning/data/hive_database.dart';
import 'package:learning/utils/constants/app_sizes.dart';
import 'package:learning/widget/add_task.dart';
import 'package:learning/widget/custom_search_delegate.dart';
import 'package:learning/widget/to_do_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoDB db = TodoDB();
  final _myBox = Hive.box('mybox');

  final TextEditingController _toDoController = TextEditingController();

  @override
  void initState() {
    if (_myBox.get('LISTOFTASK') == null) {
      db.createInitialDat();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.PAGE_PADDING),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Expanded(
                child: db.listOfTasks.isNotEmpty
                    ? ListView.builder(
                        itemCount: db.listOfTasks.length,
                        itemBuilder: (context, index) {
                          return ToDoTile(
                            taskName: db.listOfTasks[index]['task'],
                            taskCompleted: db.listOfTasks[index]['isActive'],
                            onChanged: (value) => isTaskCompleted(value, index),
                            deleteAtIndex: (context) =>
                                deleteTask(context, index),
                          );
                        },
                      )
                    : const Center(
                        child: Text("No Task"),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(
          eccentricity: 0.1,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTask(
              controller: _toDoController,
              onChanged: addTask,
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(12),
        elevation: 5,
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        height: 64,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(
                Icons.list,
                size: 32,
              ),
              const SizedBox(width: 10),
              Text(
                "ToDo",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              IconButton(
                onPressed: () => showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(db.listOfTasks),
                ),
                icon: const Icon(
                  Icons.search_rounded,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask(BuildContext context, int index) {
    db.listOfTasks.removeAt(index);
    db.updateDataBase();
    setState(() {});
  }

  void isTaskCompleted(bool? value, int index) {
    db.listOfTasks[index]['isActive'] = !db.listOfTasks[index]['isActive'];
    db.updateDataBase();
    setState(() {});
  }

  void addTask() {
    if (_toDoController.text.isNotEmpty) {
      String task = json.encode(
        {
          "task": _toDoController.text,
          "isActive": false,
        },
      );
      db.listOfTasks.add(jsonDecode(task));
      db.updateDataBase();
      _toDoController.clear();
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Empty Field");
    }
    setState(() {});
  }
}
