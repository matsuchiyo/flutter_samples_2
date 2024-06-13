import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Formatter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Number Formatter'),
        ),
        body: NumberInputField(),
      ),
    );
  }
}

class NumberInputField extends StatefulWidget {
  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_formatNumber);
  }

  @override
  void dispose() {
    _controller.removeListener(_formatNumber);
    _controller.dispose();
    super.dispose();
  }

  String? previous;

  void _formatNumber() {
    print('***** _formtNumber text: ${_controller.text}');
    if (_controller.text == previous) return;
    String text = _controller.text.replaceAll(',', '');
    if (text.isNotEmpty) {
      text = NumberFormat('#,###').format(int.parse(text));
      _controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
    previous = text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
        inputFormatters: [
          // FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: 'Enter a number',
        ),
      ),
    );
  }
}