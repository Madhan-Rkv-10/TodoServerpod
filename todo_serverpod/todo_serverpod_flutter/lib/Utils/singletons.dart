import 'package:get_it/get_it.dart';
import 'package:todo_serverpod_flutter/Utils/api_client.dart';
import 'package:todo_serverpod_flutter/Utils/todo_services.dart';

GetIt singleton = GetIt.instance;

Future<void> initSingletons() async {
  singleton.registerSingleton<ApiClient>(ApiClientImplementation());
  singleton.registerSingleton<TodoServices>(TodoRepository());

  await singleton<ApiClient>().init();
}
