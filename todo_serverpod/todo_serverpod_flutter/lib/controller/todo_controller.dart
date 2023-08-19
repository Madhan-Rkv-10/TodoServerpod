import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_serverpod_client/todo_serverpod_client.dart';
import 'package:todo_serverpod_flutter/Utils/todo_services.dart';

import '../Utils/api_client.dart';
import '../Utils/singletons.dart';
// import '../domainModel/todo_model.dart';

final todoProvider = StateNotifierProvider<TodoController, List<Todo>>((ref) {
  return TodoController(ref);
});

class TodoController extends StateNotifier<List<Todo>> {
  final Ref ref;

  final client = singleton<ApiClient>().client;
  final repo = singleton<TodoServices>();
  TodoController(this.ref) : super([]) {
    // repo = ref.read(providerHive);
    fetchTodo();
  }

  void fetchTodo() async {
    state = await repo.fetAllTodo();
  }

  ///add todo to local Storage

  void addTodo(Todo todo) async {
    final data = await repo.addTodo(todo);
    if (data) {
      fetchTodo();
    }
  }

  ///remove todo from local Storage
  void removeTodo(int id) async {
    final data = await repo.deleteTodo(id);
    if (data) {
      fetchTodo();
    }
  }

  ///Update  current todo from local Storage

  void updateTodo(int id) async {
    final data = await repo.deleteTodo(id);
    if (data) {
      fetchTodo();
    }
  }
}

final todoNotifier =
    AsyncNotifierProvider<TodoNotifier, List<Todo>>(TodoNotifier.new);

class TodoNotifier extends AsyncNotifier<List<Todo>> {
  final repo = singleton<TodoServices>();

  @override
  FutureOr<List<Todo>> build() async {
    return await repo.fetAllTodo();
  }

  void fetchTodo() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return repo.fetAllTodo();
    });
  }

  void addTodo(Todo todo) async {
    final data = await repo.addTodo(todo);
    if (data) {
      fetchTodo();
    }
  }

  ///remove todo from local Storage
  void removeTodo(int id) async {
    final data = await repo.deleteTodo(id);
    if (data) {
      fetchTodo();
    }
  }

  ///Update  current todo from local Storage

  void updateTodo(int id) async {
    final data = await repo.deleteTodo(id);
    if (data) {
      fetchTodo();
    }
  }
}
