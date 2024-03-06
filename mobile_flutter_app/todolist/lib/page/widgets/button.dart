import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/database/data/database.dart';
import 'package:todolist/provider/provider.dart';

class Buttons {
  Widget buildFloatingActionButton(BuildContext context) {
    String text = "";
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Enter Task Title'),
              content: TextField(
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                onChanged: (value) {
                  text = value;
                },
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Perform action with the entered title
                    if (text.isNotEmpty) {
                      LocalDatabase().createTask(title: text);
                      context
                          .read<RefreshProvider>()
                          .refreshData(isDataRefreshing: true);
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
