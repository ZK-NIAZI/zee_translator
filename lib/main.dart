import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zee_translator/app/cubit/lang_cubit/language_cubit.dart';
import 'package:zee_translator/app/ui/translator_screen.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TranslatorScreen(),
      ),
    );
  }
}
