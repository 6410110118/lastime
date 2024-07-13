import 'dart:async';
import 'package:equatable/equatable.dart';
import '../../models/task.dart';
import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnFavoriteTask>(_onMarkFavoriteOrUnFavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTask);
    on<LoadDeadlines>(_onLoadDeadlines);
  }

  FutureOr<void> _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final newTask = event.task;
    final updatedPendingTasks = List<Task>.from(state.pendingTasks)..add(newTask);
    final updatedDeadlineTasks = List<Task>.from(state.deadlineTasks)..add(newTask);

    emit(state.copyWith(
      pendingTasks: updatedPendingTasks,
      deadlineTasks: updatedDeadlineTasks,
    ));
  }

  FutureOr<void> _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
  final state = this.state;
  final task = event.task;
  final updatedTask = task.copyWith(isDone: !task.isDone!);
  List<Task> pendingTasks = List.from(state.pendingTasks);
  List<Task> completedTasks = List.from(state.completedTasks);
  List<Task> favoriteTasks = List.from(state.favoriteTasks);

  if (updatedTask.isDone!) {
    pendingTasks.removeWhere((t) => t.id == task.id);
    completedTasks.insert(0, updatedTask);
  } else {
    completedTasks.removeWhere((t) => t.id == task.id);
    pendingTasks.insert(0, updatedTask);
  }

  if (task.isFavorite!) {
    final favoriteIndex = favoriteTasks.indexWhere((t) => t.id == task.id);
    favoriteTasks[favoriteIndex] = updatedTask;
  }

  emit(state.copyWith(
    pendingTasks: pendingTasks,
    completedTasks: completedTasks,
    favoriteTasks: favoriteTasks,
  ));
}


  FutureOr<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final updatedRemovedTasks = List<Task>.from(state.removedTasks)..remove(event.task);

    emit(state.copyWith(removedTasks: updatedRemovedTasks));
  }

  FutureOr<void> _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final updatedPendingTasks = List<Task>.from(state.pendingTasks)..remove(event.task);
    final updatedCompletedTasks = List<Task>.from(state.completedTasks)..remove(event.task);
    final updatedFavoriteTasks = List<Task>.from(state.favoriteTasks)..remove(event.task);
    final updatedRemovedTasks = List<Task>.from(state.removedTasks)
      ..add(event.task.copyWith(isDeleted: true));
    final updatedDeadlineTasks = List<Task>.from(state.deadlineTasks)..remove(event.task);

    emit(state.copyWith(
      pendingTasks: updatedPendingTasks,
      completedTasks: updatedCompletedTasks,
      favoriteTasks: updatedFavoriteTasks,
      removedTasks: updatedRemovedTasks,
      deadlineTasks: updatedDeadlineTasks,
    ));
  }

  FutureOr<void> _onMarkFavoriteOrUnFavoriteTask(
      MarkFavoriteOrUnFavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final updatedTask = event.task.copyWith(isFavorite: !event.task.isFavorite!);
    final List<Task> pendingTasks = state.pendingTasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
    final List<Task> completedTasks = state.completedTasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
    final List<Task> favoriteTasks = state.favoriteTasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();

    if (updatedTask.isFavorite!) {
      favoriteTasks.add(updatedTask);
    } else {
      favoriteTasks.removeWhere((task) => task.id == updatedTask.id);
    }

    emit(state.copyWith(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
    ));
  }

  FutureOr<void> _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final updatedTask = event.newTask;
    final List<Task> pendingTasks = state.pendingTasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
    final List<Task> completedTasks = state.completedTasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
    final List<Task> favoriteTasks = state.favoriteTasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
    final List<Task> deadlineTasks = state.deadlineTasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();

    emit(state.copyWith(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      deadlineTasks: deadlineTasks,
    ));
  }

  FutureOr<void> _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final restoredTask = event.task.copyWith(
      isDeleted: false,
      isDone: false,
      isFavorite: false,
    );
    final updatedRemovedTasks = List<Task>.from(state.removedTasks)..remove(event.task);
    final updatedPendingTasks = List<Task>.from(state.pendingTasks)..insert(0, restoredTask);

    emit(state.copyWith(
      removedTasks: updatedRemovedTasks,
      pendingTasks: updatedPendingTasks,
    ));
  }

  FutureOr<void> _onDeleteAllTask(DeleteAllTasks event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(state.copyWith(
      removedTasks: [],
    ));
  }

  FutureOr<void> _onLoadDeadlines(LoadDeadlines event, Emitter<TasksState> emit) {
    final state = this.state;
    final deadlines = state.pendingTasks.where((task) => task.date.isNotEmpty).toList();

    emit(state.copyWith(
      deadlineTasks: deadlines,
    ));
  }
  

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
