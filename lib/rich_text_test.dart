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
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic, // alphabeticとideographicの違いについて参考: https://stackoverflow.com/a/56910192/8834586
              children: [
                Text(
                  '\$',
                  style: TextStyle(
                    fontSize: 24,
                    color: const Color(0xFF000000),
                  ),
                ),
                Text(
                  '100',
                  style: TextStyle(
                    fontSize: 36,
                    color: const Color(0xFF000000),
                  ),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\$',
                    style: TextStyle(
                      fontSize: 24,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  TextSpan(
                    text: '100',
                    style: TextStyle(
                      fontSize: 36,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
            CustomPaint(
              painter: _MyPainter(),
            ),
            const SizedBox(height: 100),

            // baselineOffset(baselineからのずれの高さ)を指定する方法は、厳密にはない。
            // そのため、CrossAxisAlignment.endを指定しつつ、Paddingを使う。
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    '\$',
                    style: TextStyle(
                      fontSize: 24,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
                Text(
                  '100',
                  style: TextStyle(
                    fontSize: 36,
                    color: const Color(0xFF000000),
                  ),
                ),
              ],
            ),

            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 24,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),

                    // 以下の指定をすると、Paddingが効かなかった。
                    // alignment: PlaceholderAlignment.baseline,
                    // baseline: TextBaseline.alphabetic,

                    alignment: PlaceholderAlignment.bottom,
                  ),
                  TextSpan(
                    text: '100',
                    style: TextStyle(
                      fontSize: 36,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
            CustomPaint(
              painter: _MyPainter2(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: '\$',
            style: TextStyle(
              fontSize: 24,
              color: const Color(0xFF000000),
            ),
          ),
          TextSpan(
            text: '100',
            style: TextStyle(
              fontSize: 36,
              color: const Color(0xFF000000),
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    textPainter.paint(canvas, const Offset(0, 0));
    textPainter.dispose();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _MyPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: '\$',
            style: TextStyle(
              fontSize: 24,
              color: const Color(0xFF000000),
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    final textHeight = textPainter.size.height;
    final textWidth = textPainter.size.width;

    final textPainter2 = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: '100',
            style: TextStyle(
              fontSize: 36,
              color: const Color(0xFF000000),
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter2.layout(minWidth: 0, maxWidth: double.infinity);
    final textHeight2 = textPainter2.size.height;
    final textWidth2 = textPainter2.size.height;

    textPainter.paint(canvas, Offset(0, textHeight2 - textHeight - 8)); // -8がbaseOffsetに相当。
    textPainter.dispose();

    textPainter2.paint(canvas, Offset(textWidth, 0));
    textPainter2.dispose();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}