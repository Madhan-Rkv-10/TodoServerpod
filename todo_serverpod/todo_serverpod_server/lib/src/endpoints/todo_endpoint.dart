import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class TodoEndpoint extends Endpoint {
  Future<List<Todo>> getTodos(Session session, {String? keyword}) async {
    return await Todo.find(
      session,
      where: (t) =>
          keyword != null ? t.id.equals(int.parse(keyword)) : Constant(true),
    );
  }

  //Add Todo in DB
  Future<bool> addTodo(Session session, Todo todos) async {
    await Todo.insert(session, todos);
    return true;
  }

  ///Update Todo
  Future<bool> updateTodo(Session session, Todo todo) async {
    final data = await Todo.findSingleRow(
      session,
      where: (todos) => todos.id.equals(todo.id),
    );
    data?.title = todo.title;
    data?.content = todo.content;
    final result = await Todo.update(
      session,
      data!,
    );
    return result;
  }

  ///Delete Todo
  Future<bool> deleteTodo(Session session, int id) async {
    var result = await Todo.delete(session, where: (t) => t.id.equals(id));
    return result == 1;
  }
}
