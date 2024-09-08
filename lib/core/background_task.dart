// import 'package:workmanager/workmanager.dart';
// import 'package:flutter/material.dart';
// import '../domain/usecases/sync_data_usecase.dart';
// import '../injector.dart'; // Assume you have a dependency injection setup

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     final syncDataUsecase = getIt<SyncDataUsecase>(); // Retrieve your use case via DI
//     await syncDataUsecase.execute(); // Call the sync data use case
//     return Future.value(true);
//   });
// }

// void initializeBackgroundTasks() {
//   Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
//   Workmanager().registerPeriodicTask(
//     "1",
//     "syncTask",
//     frequency: Duration(hours: 6),
//   );
// }
