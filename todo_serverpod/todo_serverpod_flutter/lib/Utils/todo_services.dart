import 'package:todo_serverpod_client/todo_serverpod_client.dart';
import 'package:todo_serverpod_flutter/Utils/api_client.dart';
import 'package:todo_serverpod_flutter/Utils/singletons.dart';
// import 'package:todo_serverpod_flutter/domainModel/todo_model.dart';

// import '../domainModel/todo_model.dart' show Todo;

abstract class TodoServices {
  Future<List<Todo>> fetAllTodo();
  Future<bool> addTodo(Todo todo);
  Future<bool> updateTodo(Todo todo);
  Future<bool> deleteTodo(int id);
}

class TodoRepository implements TodoServices {
  final client = singleton<ApiClient>().client;

  @override
  Future<bool> addTodo(Todo todos) async {
    final data = await client.todo.addTodo(todos);
    return data;
  }

  @override
  Future<bool> deleteTodo(int id) async {
    final data = await client.todo.deleteTodo(id);
    return data;
  }

  @override
  Future<List<Todo>> fetAllTodo() async {
    final data = await client.todo.getTodos();
    return data;
  }

  @override
  Future<bool> updateTodo(Todo todo) async {
    final data = await client.todo.updateTodo(todo);
    return data;
  }
}
