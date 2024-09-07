
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Dynamic max lines',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const textStyle = TextStyle(
    fontSize: 14.0,
    height: 1.2,
    fontWeight: FontWeight.normal,
    color: Color(0xff000000),
  );

  late TextEditingController textController;
  int maxLines = 1;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textController.addListener(onTextChanged);
  }

  @override
  void dispose() {
    textController.removeListener(onTextChanged);
    super.dispose();
  }

  void onTextChanged() {
    final text = textController.text;
    final size = calculateTextSize(text, textStyle, maxLines: 1);
    print('***** onTextChanged currentMaxLines: $maxLines, text: $text, width: ${size.width}');
    setState(() {
      // maxLines = size.width > (375.0 - 16 * 2) ? 1000 : 1;
      maxLines = size.width > (375.0 - 16 * 2) ? 2 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: CupertinoTextField(
                  controller: textController,
                  maxLines: maxLines,
                  // maxLines: 1000,
                  style: textStyle,
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
            ],
          ),
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