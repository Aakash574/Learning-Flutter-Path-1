import 'package:hive/hive.dart';

class TodoDB {
  List<dynamic> listOfTasks = [];

  final _myBox = Hive.box('mybox');

  void createInitialDat() {
    listOfTasks = [
      {
        'task': "First Time",
        'isActive': false,
      }
    ];
  }

  void loadData() {
    listOfTasks = _myBox.get('LISTOFTASK');
  }

  void updateDataBase() {
    _myBox.put('LISTOFTASK', listOfTasks);
  }
}
