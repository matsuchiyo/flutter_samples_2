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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: TextButton(
          child: const Text('foo'),
          onPressed: () async {
            Future<String> future = Future.delayed(const Duration(seconds: 4), () => 'Complete');
            try {
              await Stream
                .fromFuture(future)
                // .timeout(const Duration(seconds: 1), onTimeout: (_) => throw 'Custom timeout') // cannot catch
                .timeout(const Duration(seconds: 1), onTimeout: (sink) => sink.addError('Custom timeout')) // can catch
                .handleError((error, stack) {
                  throw 'Custom timeout 2';
                })
                .first;
            } catch (e, s) {
              print('***** e: $e');
            }
          },
        ),
      ),
    );
  }
}