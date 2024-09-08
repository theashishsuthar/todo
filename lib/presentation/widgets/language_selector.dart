import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/language_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String languageCode) {
        context.read<LanguageBloc>().add(ChangeLanguage(languageCode));
      },
      icon: const Icon(Icons.language),
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'en',
          child: Text('English'),
        ),
        const PopupMenuItem(
          value: 'ar',
          child: Text('العربية'),
        ),
      ],
    );
  }
}