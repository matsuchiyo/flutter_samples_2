import 'package:flutter/cupertino.dart';
import 'package:flutter_samples_2/cupertino_date_time_picker_sample/my_toolbar.dart';

// 参考: https://api.flutter.dev/flutter/cupertino/CupertinoDatePicker-class.html

Future<DateTime?> showDateTimePicker(
    BuildContext context,
    {
      DateTime? initialDateTime,
    }
    ) {
  return showCupertinoModalPopup<DateTime>(
    context: context,
    builder: (BuildContext context) => _DateTimePickerPopup(
      initialDateTime: initialDateTime,
    ),
  );
}

class _DateTimePickerPopup extends StatefulWidget {
  final DateTime? initialDateTime;
  const _DateTimePickerPopup({
    super.key,
    this.initialDateTime,
  });
  @override
  State<_DateTimePickerPopup> createState() => _DateTimePickerPopupState();
}

class _DateTimePickerPopupState extends State<_DateTimePickerPopup> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyToolbar(
          onCancelTap: () => Navigator.pop(context),
          onCompleteTap: () => Navigator.pop(context, _selectedDateTime),
        ),
        Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            /*
            child: CupertinoDatePicker(
              initialDateTime: widget.initialDateTime,
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newDate) {
                _selectedDateTime = newDate;
                setState(() {});
              },
            ),
             */
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 5,
                  child: CupertinoDatePicker(
                    initialDateTime: widget.initialDateTime,
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    onDateTimeChanged: (DateTime newDate) {
                      _selectedDateTime = DateTime(
                        newDate.year,
                        newDate.month,
                        newDate.day,
                        _selectedDateTime.hour,
                        _selectedDateTime.minute,
                      );
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CupertinoDatePicker(
                    initialDateTime: widget.initialDateTime,
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                    onDateTimeChanged: (DateTime newDate) {
                      _selectedDateTime = DateTime(
                        _selectedDateTime.year,
                        _selectedDateTime.month,
                        _selectedDateTime.day,
                        newDate.hour,
                        newDate.minute,
                      );
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}