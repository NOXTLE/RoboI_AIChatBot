import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statem/chatpage.dart';
import 'package:statem/myprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => pageProvider())],
      child: MaterialApp(
          theme: ThemeData(
              colorScheme: const ColorScheme.dark(),
              textTheme: Typography.blackCupertino),
          debugShowCheckedModeBanner: false,
          home: ChatPage()),
    );
  }
}
