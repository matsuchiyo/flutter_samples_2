import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_samples_2/cupertino_date_time_picker_sample/show_date_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
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
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final dateFormat = DateFormat.yMd().add_Hm();

  @override
  void initState() {
    super.initState();

    _controller.text = dateFormat.format(DateTime.now());

    _focusNode.addListener(() async {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
        final dateText = _controller.text;
        final DateTime initialDateTime = dateFormat.parse(dateText);
        final DateTime? selectedDateTime = await showDateTimePicker(
            context,
            initialDateTime: initialDateTime,
        );
        if (selectedDateTime == null) return;
        _controller.text = dateFormat.format(selectedDateTime);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('hoge'),
      ),
      child: Center(
        child: CupertinoTextField(
          controller: _controller,
          focusNode: _focusNode,
          keyboardType: TextInputType.none,
        ),
      ),
    );
  }
}