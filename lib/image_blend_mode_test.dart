import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'hoge'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/check.png',
              width: 64,
              height: 64,
              color: const Color(0xFFFF0000),
              colorBlendMode: BlendMode.srcIn,
            ),
            const SizedBox(height: 16),
            Image.asset(
              'assets/check.png',
              width: 64,
              height: 64,
              color: const Color(0xFF00FF00),
              colorBlendMode: BlendMode.srcIn,
            ),
            const SizedBox(height: 16),
            Image.asset(
              'assets/check.png',
              width: 64,
              height: 64,
              color: const Color(0xFF0000FF),
              colorBlendMode: BlendMode.srcIn,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
