import 'package:flutter/material.dart';
import 'presentation/widgets/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff141416),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Ubuntu',
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: WidgetTree(),
    );
  }
}
