import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';
import 'recycle_bin.dart';
import 'tab_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              color: Colors.grey,
              child: Text(
                'Last Time',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(TabsScreen.id),
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text('My Tasks'),
                    trailing: Text(
                        '${state.pendingTasks.length} | ${state.completedTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Bin'),
                    trailing: Text('${state.removedTasks.length}'),
                  ),
                );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
