import 'package:flutter/material.dart';
import 'package:todo/bloc/bloc_exports.dart';
import 'package:todo/models/task.dart';

class DeadlineTasksScreen extends StatelessWidget {
  const DeadlineTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> deadlineTasks = state.pendingTasks.where((task) => task.deadline.isNotEmpty).toList();
        return ListView.builder(
          itemCount: deadlineTasks.length,
          itemBuilder: (context, index) {
            var task = deadlineTasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text('Deadline: ${task.deadline}'),
              trailing: Checkbox(
                value: task.isDone,
                onChanged: (value) {
                  context.read<TasksBloc>().add(UpdateTask(task: task.copyWith(isDone: value)));
                },
              ),
            );
          },
        );
      },
    );
  }
}