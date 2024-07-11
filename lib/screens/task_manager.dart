import 'package:flutter/foundation.dart';

class TaskManager extends ChangeNotifier {
  final List<String> _tasks = [];

  List<String> get tasks => List.unmodifiable(_tasks);

  void addTask(String task) {
    _tasks.add(task);
    notifyListeners(); // Notify listeners when data changes
  }

  List<String> searchTasks(String query) {
    return _tasks
        .where((task) => task.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
