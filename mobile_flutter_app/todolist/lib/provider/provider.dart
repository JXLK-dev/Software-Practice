import 'package:flutter/material.dart';
import 'package:todolist/database/model/task.dart';

class RefreshProvider extends ChangeNotifier {
  bool isDataRefreshing;
  List<Task> tasks = [];
  RefreshProvider({this.isDataRefreshing = false});
  void refreshData({bool? isDataRefreshing}) {
    // Perform data refresh logic here
    // For example, make an API call to fetch new data

    // Once the data is refreshed, update the flag
    this.isDataRefreshing = isDataRefreshing ?? this.isDataRefreshing;

    // Notify listeners that the data has been refreshed
    notifyListeners();
  }

  void updateTasks({required List<Task> tasks}) {
    this.tasks = tasks;
    notifyListeners();
  }
}
