// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/database/data/database.dart';
import 'package:todolist/database/model/task.dart';
import 'package:todolist/page/widgets/button.dart';
import 'package:todolist/provider/provider.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    await Future.delayed(const Duration(milliseconds: 200));
    context
        .read<RefreshProvider>()
        .updateTasks(tasks: await LocalDatabase().readTask());
    context.read<RefreshProvider>().refreshData(isDataRefreshing: false);
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<RefreshProvider>().isDataRefreshing) {
      // Perform data refresh logic here
      // For example, make an API call to fetch new data
      _loadTasks();
    }
    List<Task> tasks = context.watch<RefreshProvider>().tasks;
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          bool isTaskDone = tasks[index].taskDone;
          return Card(
            child: ListTile(
              title: Text(
                tasks[index].title,
                style: TextStyle(
                    decoration: isTaskDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      // Handle delete button press
                      await LocalDatabase().deleteTask(tasks[index].id);
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                        isTaskDone
                            ? Icons.check_circle
                            : Icons.check_circle_outline_outlined,
                        color: isTaskDone ? Colors.green : Colors.grey),
                    onPressed: () async {
                      // Handle complete button press
                      // Perform task completion logic
                      Task newTask = Task.fromJson(
                          tasks[index].copyWith(taskDone: !isTaskDone));
                      await LocalDatabase().updateTask(newTask);
                      context
                          .read<RefreshProvider>()
                          .refreshData(isDataRefreshing: true);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton:
          // Handle create button press
          // Add your logic to create new tasks here,
          Buttons().buildFloatingActionButton(context),
    );
  }
}
