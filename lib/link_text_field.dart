import 'package:flutter/gestures.dart';
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  bool readOnly = false;

  late final textController = LinkTextEditingController(
    onLinkTap: (context, url) {
      print('***** onLinkTap: url: $url');
    },
    onNormalTextTap: (context) {
    },
  );


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // readOnlyを1フレーム早く、trueにしないといけないっぽい。
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          LinkTextField(),
          TextField(),
        ],
      ),
    );
  }
}

class LinkTextField extends StatefulWidget {
  @override
  State<LinkTextField> createState() => _LinkTextFieldState();
}

class _LinkTextFieldState extends State<LinkTextField> {
  var _readOnly = true;
  final focusNode = FocusNode();

  late final linkTextController = LinkTextEditingController(
    onLinkTap: (context, url) {
      print('***** onLinkTap: url: $url');
    },
    onNormalTextTap: (context) {
      setState(() {
        _readOnly = false;
        focusNode.requestFocus();
      });
    },
  );

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          _readOnly = false;
        });
      } else {
        setState(() {
          _readOnly = true;
        });
      }
    });

    textController.addListener(() {
      linkTextController.text = textController.text;
    });

    // linkTextController.text = 'https://google.com';
  }

  @override
  Widget build(BuildContext context) {
    // デフォルトは、readonly
    // タップされたら、focusを入れる
    // focusがはずれたらreadonly

    return _readOnly ? TextField(
      key: const ValueKey('LinkTextField'),
      controller: linkTextController,
      readOnly: true,
      obscureText: false,
      onTap: () {
        print('***** onTap');
        setState(() {
          _readOnly = false;
          focusNode.requestFocus();
        });
      },
    ) : TextField(
      key: const ValueKey('TextField'),
      controller: textController,
      focusNode: focusNode,
    );
  }
}

class LinkTextEditingController extends TextEditingController {
  final regex = RegExp(
    // 参考: https://stackoverflow.com/a/3809435/8834586
    r'https?://(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)',
    caseSensitive: false,
    dotAll: true,
  );

  final void Function(BuildContext context, String url) onLinkTap;
  final void Function(BuildContext context) onNormalTextTap;

  final TextStyle linkStyle;

  LinkTextEditingController({
    required this.onLinkTap,
    required this.onNormalTextTap,
    this.linkStyle = const TextStyle(color: Colors.blue),
  });

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    print('***** buildTextSpan: withComposing: ${withComposing}, value:composing: ${value.composing}');
    assert(!value.composing.isValid || !withComposing || value.isComposingRangeValid);
    final bool composingRegionOutOfRange = !value.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      return TextSpan(
        style: style,
        children: [
          _buildLinkifiedTextSpan(context, text: text, onLinkTap: onLinkTap),
        ],
      );
    }

    final TextStyle composingStyle = style?.merge(const TextStyle(decoration: TextDecoration.underline))
        ?? const TextStyle(decoration: TextDecoration.underline);
    return TextSpan(
      style: style,
      children: <TextSpan>[

        // 変更箇所
        _buildLinkifiedTextSpan(
          context,
          text: value.composing.textBefore(value.text),
          onLinkTap: onLinkTap,
        ),

        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(value.text),
        ),

        // 変更箇所
        _buildLinkifiedTextSpan(
          context,
          text: value.composing.textAfter(value.text),
          onLinkTap: onLinkTap,
        ),
      ],
    );
  }

  TextSpan _buildLinkifiedTextSpan(
    BuildContext context,
    {
      required String text,
      required void Function(BuildContext context, String url) onLinkTap,
    }
  ) {
    List<TextSpan> textSpans = [];
    final _ = text.splitMapJoin(
      regex,
      onMatch: (Match match) {
        String? url = match[0];
        textSpans.add(TextSpan(
          text: match[0],
          style: linkStyle,
          recognizer: (TapGestureRecognizer()..onTap = () {
            if (url == null) return;
            onLinkTap(context, url);
          }),
        ));
        return "";
      },
      onNonMatch: (String text) {
        textSpans.add(TextSpan(
          text: text,
          recognizer: (TapGestureRecognizer()..onTap = () {
            onNormalTextTap(context);
          }),
        ));
        return "";
      },
    );
    return TextSpan(children: textSpans);
  }
}