import 'dart:developer';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:todo_serverpod_client/todo_serverpod_client.dart';
import 'package:todo_serverpod_flutter/Utils/singletons.dart';
import 'package:todo_serverpod_flutter/controller/todo_controller.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
final client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();
final clientProvider = Provider<Client>((ref) =>
    Client('http://localhost:8080/')
      ..connectivityMonitor = FlutterConnectivityMonitor());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await initSingletons();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Serverpod Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateController = ref.watch(todoNotifier);

    final r = ref.watch(clientProvider);
    log(r.todo.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                // controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  final data = await client.todo
                      .addTodo(Todo(title: "title", content: "content"));
                  log(data.toString());
                },
                child: const Text('Send to Server'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  final data = await client.todo.getTodos();
                  log(data.length.toString());
                  log(data.first.id.toString());
                },
                child: Text("Fetch Data"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  final data = await client.todo.deleteTodo(1);
                  log("Deleted Successfully$data");
                },
                child: const Text("Delete First Data"),
              ),
            ),
            stateController.when(
              data: (s) {
                return Text('data $s');
              },
              error: (error, t) {
                return Text('$error$t');
              },
              loading: () => CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
