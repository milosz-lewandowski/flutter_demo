import 'package:flutter/material.dart';
import 'package:flutter_demo/MarkdownScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MarkdownScreen(mdContentUrl: "https://raw.githubusercontent.com/milosz-lewandowski/flutter_demo/master/MarkdownSample.md")
    );
  }
}
