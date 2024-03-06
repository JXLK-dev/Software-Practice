// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:todolist/database/model/task.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

///An operation that manipulates data in managing task
///This operation includes reading, writing and deleting data
///Before using the operation within the class, intialize database in main.dart file
class LocalDatabase {
  LocalDatabase();
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;
  LocalDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('local.db');
    return _database!;
  }

  ///initializing database with a given configuration and a filepath for database location
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  ///Creating tables for database
  Future _createDB(Database db, int version) async {
    const textType = 'TEXT NOT NULL';
    const booleanType = 'BOOLEAN NOT NULL';
    await db.execute('''CREATE TABLE task(
      id $textType,
      title $textType,
      taskDone $booleanType
    )''');
  }

  ///Checking if the task exists in the database
  Future<bool> _checkTaskExistence({required String id}) async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT id FROM task WHERE id = "$id"');
    if (result == null || result.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  ///Generating a unique task id
  String _generateTaskID() {
    String id = 'TA';
    var rng = Random();
    for (var i = 0; i < 100; i++) {
      id = id + rng.nextInt(10).toString();
    }
    return id;
  }

  ///Creating a task in the database
  Future<void> createTask({required String title}) async {
    final db = await instance.database;
    String id = _generateTaskID();
    while (!await _checkTaskExistence(id: id)) {
      id = _generateTaskID();
    }
    await db.rawInsert(
        'INSERT INTO task(id, title, taskDone) VALUES ("$id","$title","false")');
    return;
  }

  ///reading all task from the database
  Future<List<Task>> readTask() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT * FROM task');
    List<Task> tasks = result.map((map) => Task.fromJson(map)).toList();
    return tasks;
  }

  ///deleting a task from the database
  ///The task is deleted based on the task id
  Future<void> deleteTask(String id) async {
    final db = await instance.database;
    await db.rawDelete('DELETE FROM task WHERE id = "$id"');
    return;
  }

  ///Updating a task in the database
  ///The task is updated based on the task id
  Future<void> updateTask(Task task) async {
    final db = await instance.database;
    await db.rawUpdate(
        'UPDATE task SET title = "${task.title}", taskDone = ${task.taskDone} WHERE id = "${task.id}"');
    return;
  }
}
