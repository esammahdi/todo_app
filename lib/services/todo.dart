import 'package:hive/hive.dart';
import 'package:todo_app/model/task.dart';

class TodoService {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>('tasksBox');
    await _tasks.clear();
    await _tasks.add(Task('Mahdi', 'First Task', false));
    await _tasks.add(Task('Esam Mahdi', 'Apply For Internship', false));
    await _tasks.add(Task('', 'Apply For Internship', true));
    await _tasks.add(Task('', 'Apply For Internship', true));
    await _tasks.add(Task('', 'Apply For Internship', true));
  }

  List<Task> getTasks(final String username) {
    final tasks = _tasks.values.where((element) => element.user == username);
    return tasks.toList();
  }

  Future<void> addTask(final String username, final Task task) async {
    await _tasks.add(task);
  }

  Future<void> removeTask(final String username, final String task) async {
    final taskToRemove = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    await _tasks.delete(taskToRemove.key as int);
  }

  Future<void> mark(
      final String username, final String task, final bool completed) async {
    final taskToMark = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    await _tasks.put(taskToMark.key as int, Task(username, task, completed));
  }

  Future<void> updateTask(String username, final String task,
      {final bool? completed}) async {
    final taskToUpdate = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    await _tasks.put(taskToUpdate.key as int,
        Task(username, task, completed ?? taskToUpdate.completed));
  }
}
