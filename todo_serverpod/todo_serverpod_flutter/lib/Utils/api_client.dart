import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:todo_serverpod_client/todo_serverpod_client.dart';
// import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

abstract class ApiClient {
  // late SessionManager sessionManager;
  late Client client;

  Future<void> init();
}

class ApiClientImplementation extends ApiClient {
  @override
  Future<void> init() async {
    // client = Client(
    //   'https://api.listie.online/',
    // )..connectivityMonitor = FlutterConnectivityMonitor();

    client = Client('http://localhost:8080/')
      ..connectivityMonitor = FlutterConnectivityMonitor();

    // sessionManager = SessionManager(caller: client.modules.auth);
    // await sessionManager.initialize();
  }
}
