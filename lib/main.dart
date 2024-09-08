import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/app/app.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/injection.dart';
import 'package:workmanager/workmanager.dart';

import 'core/util/app_constant.dart';
import 'core/util/language_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await configureDependencies();
  await Hive.openBox(AppConstants.languageBox);
  final String initialLanguage = await LanguageUtil.getInitialLanguage();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    "1",
    "syncTask",
    frequency: const Duration(seconds: 3),
  );
  runApp(MyApp(initialLanguage: initialLanguage,));
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async{
    print("Background sync task running");
    await Hive.initFlutter();
     Hive.registerAdapter(TodoModelAdapter());
    await configureDependencies();

  
    return Future.value(true);
  });
}