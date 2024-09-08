import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/presentation/pages/todo_list_page.dart';

import '../injection.dart';
import '../presentation/bloc/language_bloc.dart';
import '../presentation/bloc/todo_bloc.dart';

class MyApp extends StatelessWidget {
  final String initialLanguage;

  const MyApp({super.key,required this.initialLanguage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<TodoBloc>(),
        ),
        BlocProvider.value(
          value: LanguageBloc()..add(GetSavedLanguage()),
        )
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context,state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TODO App',
            locale: Locale(state.languageCode),
            theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true,scaffoldBackgroundColor: Colors.white,visualDensity: VisualDensity.adaptivePlatformDensity,),
            supportedLocales: const [Locale('en', ''), Locale('ar', '')],
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home:  const TodoListPage(),
          );
        }
      ),
    );
  }
}
