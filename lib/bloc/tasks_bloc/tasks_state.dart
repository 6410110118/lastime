part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favoriteTasks;
  final List<Task> removedTasks;
  final List<Task> deadlineTasks;

  const TasksState({
    this.pendingTasks = const <Task>[],
    this.completedTasks = const <Task>[],
    this.favoriteTasks = const <Task>[],
    this.removedTasks = const <Task>[],
    this.deadlineTasks = const <Task>[],
  });
   TasksState copyWith({
    List<Task>? pendingTasks,
    List<Task>? completedTasks,
    List<Task>? favoriteTasks,
    List<Task>? removedTasks,
    List<Task>? deadlineTasks,
  }) {
    return TasksState(
      pendingTasks: pendingTasks ?? this.pendingTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      favoriteTasks: favoriteTasks ?? this.favoriteTasks,
      removedTasks: removedTasks ?? this.removedTasks,
      deadlineTasks: deadlineTasks ?? this.deadlineTasks,
    );
  }

  @override
  List<Object> get props => [
        pendingTasks,
        completedTasks,
        favoriteTasks,
        removedTasks,
        deadlineTasks,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'favoriteTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'removedTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'deadlneTasks': deadlineTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTasks: List<Task>.from(
        (map['pendingTasks'])?.map<Task>(
          (x) => Task.fromMap(x),
        ),
      ),
      completedTasks: List<Task>.from(
        (map['completedTasks'])?.map<Task>(
          (x) => Task.fromMap(x),
        ),
      ),
      favoriteTasks: List<Task>.from(
        (map['favoriteTasks'])?.map<Task>(
          (x) => Task.fromMap(x),
        ),
      ),
      removedTasks: List<Task>.from(
        (map['removedTasks'])?.map<Task>(
          (x) => Task.fromMap(x),
        ),
      ),
      deadlineTasks: List<Task>.from(
        (map['deadlineTasks'])?.map<Task>(
          (x) => Task.fromMap(x),
        )
      )
    );
  }
}
