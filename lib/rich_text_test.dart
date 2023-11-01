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

const numberStyle = TextStyle(
  fontSize: 36,
  color: Color(0xFF000000),
  height: 1.0,
);

const nonNumberStyle = TextStyle(
  fontSize: 24,
  color: Color(0xFF000000),
  height: 1.0,
);

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
            _rowBaseline(),
            _richTextBaseline(),
            _customPainterBaseline(),
            const SizedBox(height: 50),

            // baselineOffset(baselineからのずれの高さ)を指定する方法は、厳密にはない。
            // そのため、CrossAxisAlignment.endを指定しつつ、Paddingを使う。
            // iOSにはある。https://developer.apple.com/documentation/foundation/nsattributedstring/key/1526427-baselineoffset
            _rowBottomOffset(),
            _richTextBottomOffset(),
            _customPainterBottomOffset(),
            const SizedBox(height: 50),

            NumberAndNonNumberText(
              allText: '\$100',
              nonNumberText: '\$',
              numberTextStyle: numberStyle,
              nonNumberTextStyle: nonNumberStyle,
            ),
            NumberAndNonNumberText(
              allText: '\$100',
              nonNumberText: '\$',
              numberTextStyle: numberStyle,
              nonNumberTextStyle: nonNumberStyle,
              nonNumberTextBottomOffset: 8,
              spaceBetweenNumberAndNonNumber: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowBaseline() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic, // alphabeticとideographicの違いについて参考: https://stackoverflow.com/a/56910192/8834586
      children: [
        Text(
          '\$',
          style: nonNumberStyle,
        ),
        Text(
          '100',
          style: numberStyle,
        ),
      ],
    );
  }

  Widget _richTextBaseline() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: '\$',
            style: nonNumberStyle,
          ),
          TextSpan(
            text: '100',
            style: numberStyle,
          ),
        ],
      ),
    );
  }

  Widget _customPainterBaseline() {
    return CustomPaint(
      painter: _MyPainter(),
    );
  }

  Widget _rowBottomOffset() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            '\$',
            style: nonNumberStyle,
          ),
        ),
        Text(
          '100',
          style: numberStyle,
        ),
      ],
    );
  }

  Widget _richTextBottomOffset() {
    return RichText(
      text: const TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                '\$',
                style: nonNumberStyle,
              ),
            ),

            // 以下の指定をすると、Paddingが効かなかった。
            // alignment: PlaceholderAlignment.baseline,
            // baseline: TextBaseline.alphabetic,

            alignment: PlaceholderAlignment.bottom,
          ),
          TextSpan(
            text: '100',
            style: numberStyle,
          ),
        ],
      ),
    );
  }

  Widget _customPainterBottomOffset() {
    return CustomPaint(
      painter: _MyPainter2(),
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
            style: nonNumberStyle,
          ),
          TextSpan(
            text: '100',
            style: numberStyle,
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
            style: nonNumberStyle,
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
            style: numberStyle,
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

class NumberAndNonNumberText extends StatefulWidget {
  final String allText;
  final String nonNumberText;
  final TextStyle numberTextStyle;
  final TextStyle nonNumberTextStyle;
  final double? nonNumberTextBottomOffset;
  final double? spaceBetweenNumberAndNonNumber;
  const NumberAndNonNumberText({
    super.key,
    required this.allText,
    required this.nonNumberText,
    required this.numberTextStyle,
    required this.nonNumberTextStyle,
    this.nonNumberTextBottomOffset,
    this.spaceBetweenNumberAndNonNumber,
  });

  @override
  State<NumberAndNonNumberText> createState() => _NumberAndNonNumberTextState();
}

class _NumberAndNonNumberTextState extends State<NumberAndNonNumberText> {

  late final List<_Element> _elements;

  @override
  void initState() {
    super.initState();
    _elements = _createElements(
      widget.allText,
      widget.nonNumberText,
      widget.numberTextStyle,
      widget.nonNumberTextStyle,
      widget.nonNumberTextBottomOffset,
      widget.spaceBetweenNumberAndNonNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    final shouldBeCrossAxisAlignmentBaseline = _elements.every((e) => e.bottomOffset == 0);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: shouldBeCrossAxisAlignmentBaseline ? CrossAxisAlignment.baseline : CrossAxisAlignment.end,
      textBaseline: shouldBeCrossAxisAlignmentBaseline ? TextBaseline.alphabetic : null,
      children: _elements.expand((e) {
        return [
          shouldBeCrossAxisAlignmentBaseline
            ? Text(
              e.text,
              style: e.style,
            )
            : Padding(
              padding: EdgeInsets.only(bottom: e.bottomOffset),
              child: Text(
                e.text,
                style: e.style,
              ),
            ),
          SizedBox(width: e.trailingSpace),
        ];
      }).toList(),
    );
  }


  List<_Element> _createElements(
    String allText,
    String nonNumberText,
    TextStyle numberTextStyle,
    TextStyle nonNumberTextStyle,
    double? nonNumberTextBottomOffset,
    double? spaceBetweenNumberAndNonNumber,
  ) {
    // nonNumberTextはallTextの、先頭または途中または末尾に、1度だけ現れる想定。

    final index = allText.indexOf(nonNumberText);
    if (index < 0) {
      return [_Element(allText, numberTextStyle, 0, 0)];
    }

    List<_Element> result = [];
    if (index > 0) {
      result.add(_Element(allText.substring(0, index), numberTextStyle, 0, spaceBetweenNumberAndNonNumber ?? 0));
    }

    final nextIndexOfNonNumberTextLastCharIndex = index + nonNumberText.length;
    final double spaceAfterNonNumberText = nextIndexOfNonNumberTextLastCharIndex < allText.length ? (spaceBetweenNumberAndNonNumber ?? 0) : 0;
    result.add(_Element(nonNumberText, nonNumberTextStyle, nonNumberTextBottomOffset ?? 0, spaceAfterNonNumberText));

    if (nextIndexOfNonNumberTextLastCharIndex < allText.length) {
      result.add(_Element(allText.substring(nextIndexOfNonNumberTextLastCharIndex), numberTextStyle, 0, 0));
    }

    return result;
  }
}

class _Element {
  final String text;
  final TextStyle style;
  final double bottomOffset;
  final double trailingSpace;
  _Element(this.text, this.style, this.bottomOffset, this.trailingSpace);
}