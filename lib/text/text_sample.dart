

import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: MyHomePage(title: "Home"),
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
  static const text = 'ABCD\nefgh';
  static const textStyle = TextStyle(
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w400,
    fontSize: 48,
    height: 48.0 / 48.0,
  );

  late Size calculatedTextSize;

  @override
  void initState() {
    super.initState();
    calculatedTextSize = calculateTextSize(text, textStyle);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Home')),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              text,
              style: textStyle,
            ),
            const SizedBox(height: 24),
            Text(
              'calculatedHeight: ${calculatedTextSize.height}',
            ),
          ],
        ),
      ),
    );
  }
}

Size calculateTextSize(String text, TextStyle style, { double? maxWidth, int? maxLines }) {
  final textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: style,
    ),
    maxLines: maxLines ?? 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: maxWidth ?? double.infinity);
  return textPainter.size;
}