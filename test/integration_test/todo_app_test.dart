import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo/app/app.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/injection.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mocks.dart'; // Adjust import

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // setUpAll(() async {
  //   try {
  //     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //     print('Firebase initialized successfully.');
  //   } catch (e) {
  //     print('Error initializing Firebase: $e');
  //   }

  //   try {
  //     await Hive.initFlutter();
  //     Hive.registerAdapter(TodoModelAdapter());
  //     await Hive.openBox('languageBox');
  //     print('Hive initialized and boxes opened.');
  //   } catch (e) {
  //     print('Error initializing Hive: $e');
  //   }

  //   try {
  //     await configureDependencies();
  //     print('Dependencies configured successfully.');
  //   } catch (e) {
  //     print('Error configuring dependencies: $e');
  //   }
  // });

  setUpAll(() async {
    final mockFirebaseApp = MockFirebaseApp();
    final mockFirebaseFirestore = MockFirebaseFirestore();

    when(Firebase.initializeApp()).thenAnswer((_) async => mockFirebaseApp);
    when(FirebaseFirestore.instance).thenReturn(mockFirebaseFirestore);

    await configureDependencies();
  });

  testWidgets('Add a new to-do item', (WidgetTester tester) async {
    await configureDependencies();
    await tester.pumpWidget(const MyApp(initialLanguage: 'en'));

    expect(find.text('No items'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Buy groceries');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    expect(find.text('Buy groceries'), findsOneWidget);
  });

  testWidgets('Edit an existing to-do item', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(initialLanguage: 'en'));

    await tester.tap(find.text('Add item'));

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Buy groceries');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Buy groceries'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Buy groceries and milk');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    expect(find.text('Buy groceries and milk'), findsOneWidget);
  });

  testWidgets('Delete a to-do item', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(initialLanguage: 'en'));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Buy groceries');
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    await tester.drag(find.text('Buy groceries'), Offset(-500, 0));
    await tester.pumpAndSettle();

    expect(find.text('Buy groceries'), findsNothing);
  });
}
