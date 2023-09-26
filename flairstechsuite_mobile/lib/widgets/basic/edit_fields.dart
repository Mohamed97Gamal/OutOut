import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef ValidateField = String? Function(String? value);

class StringEditingField extends StatefulWidget {
  final Map? _map;
  final String _fieldName;
  final String _fieldMapName;
  final ValidateField _validateField;

  final bool isRequired;
  final bool isCentered;
  final int maxLines;
  final bool outLineBorder;
  final bool numberOnlyKeyboard;

  const StringEditingField(this._map, this._fieldName, this._fieldMapName, this._validateField,
      {this.maxLines = 1,
      this.outLineBorder = false,
      this.isRequired = false,
      this.isCentered = false,
      this.numberOnlyKeyboard = false});

  @override
  _StringEditingFieldState createState() => _StringEditingFieldState();
}

class _StringEditingFieldState extends State<StringEditingField> {
  final TextEditingController tc = TextEditingController();

  @override
  void initState() {
    super.initState();
    if ((!widget._map!.containsKey(widget._fieldMapName)) || widget._map![widget._fieldMapName].toString().isEmpty) {
      widget._map![widget._fieldMapName] = "";
    }
    tc.text = widget._map![widget._fieldMapName] as String;
    tc.addListener(() => widget._map![widget._fieldMapName] = tc.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
           SizedBox(height: widget.outLineBorder ? 22.0 : 0.0),
          TextFormField(
            keyboardType: widget.numberOnlyKeyboard ? TextInputType.number : null,
            textAlign: widget.isCentered ? TextAlign.center : TextAlign.start,
            maxLines: widget.maxLines,
            validator: widget._validateField,
            controller: tc,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: Colors.grey
              ),
              border: widget.outLineBorder ? const OutlineInputBorder() : null,
              labelText: widget._fieldName + (widget.isRequired ? " *" : ""),
            ),
          ),
           SizedBox(height: widget.outLineBorder ? 0.0 : 4.0),
        ],
      ),
    );
  }
}

class IntEditingField extends StatefulWidget {
  final Map? _map;
  final String _fieldName;
  final String _fieldMapName;
  final ValidateField _validateField;

  final bool isRequired;
  final bool isCentered;
  final int maxLines;
  final bool outLineBorder;
  final String? suffixText;
  final bool emptyIfZero;

  const IntEditingField(this._map, this._fieldName, this._fieldMapName, this._validateField,
      {this.maxLines = 1,
      this.outLineBorder = false,
      this.isRequired = false,
      this.isCentered = false,
      this.emptyIfZero = true,
      this.suffixText});

  @override
  _IntEditingFieldState createState() => _IntEditingFieldState();
}

class _IntEditingFieldState extends State<IntEditingField> {
  final TextEditingController tc = TextEditingController();

  @override
  void initState() {
    super.initState();
    if ((!widget._map!.containsKey(widget._fieldMapName)) || widget._map![widget._fieldMapName] == null) {
      widget._map![widget._fieldMapName] = 0;
    }
    if (widget._map![widget._fieldMapName] == 0 && widget.emptyIfZero == true) {
      tc.text = "";
    } else {
      tc.text = widget._map![widget._fieldMapName].toString();
    }
    tc.addListener(() => widget._map![widget._fieldMapName] = int.tryParse(tc.text) ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
           SizedBox(height: widget.outLineBorder ? 22.0 : 0.0),
          TextFormField(
            keyboardType: TextInputType.number,
            textAlign: widget.isCentered ? TextAlign.center : TextAlign.start,
            maxLines: widget.maxLines,
            validator: widget._validateField,
            controller: tc,
            decoration: InputDecoration(
              suffixText: widget.suffixText,
              border: widget.outLineBorder ? const OutlineInputBorder() : null,
              labelText: widget._fieldName + (widget.isRequired ? " *" : ""),
              labelStyle: TextStyle(
                  color: Colors.grey
              ),
            ),
          ),
           SizedBox(height: widget.outLineBorder ? 0.0 : 4.0),
        ],
      ),
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({Key? key, this.child, this.valueText, this.valueStyle, this.onPressed, this.fontSize})
      : super(key: key);

  final double? fontSize;
  final String? valueText;
  final TextStyle? valueStyle;
  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(valueText!),
          Icon(Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade700 : Colors.white70),
        ],
      ),
    );
  }
}

//DateTimePicker
class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key? key,
    this.selectedDate,
    this.selectDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  final DateTime? selectedDate;
  final ValueChanged<DateTime>? selectDate;

  final DateTime? firstDate;
  final DateTime? lastDate;

  Future _selectDate(BuildContext context) async {
    if (selectDate == null) {
      return;
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: firstDate ?? DateTime(1800),
      lastDate: lastDate ?? DateTime(2100),
    );
    if (picked != null && picked != selectedDate) selectDate!(picked);
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.headline6;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: _InputDropdown(
            valueText: DateFormat("MMM dd, yyyy").format(selectedDate!),
            valueStyle: valueStyle,
            onPressed: selectDate == null
                ? null
                : () {
                    _selectDate(context);
                  },
          ),
        ),
      ],
    );
  }
}

class DateEditingField extends StatefulWidget {
  final Map map;
  final String datePattern, mapField;

  const DateEditingField(this.map, this.mapField, this.datePattern);

  @override
  _DateEditingFieldState createState() =>
      _DateEditingFieldState(DateFormat(datePattern).parse(map[mapField] as String));
}

class _DateEditingFieldState extends State<DateEditingField> {
  DateTime _dateValue;

  _DateEditingFieldState(this._dateValue);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DateTimePicker(
        selectedDate: _dateValue,
        selectDate: (date) {
          setState(() {
            _dateValue = date;
            widget.map[widget.mapField] = DateFormat(widget.datePattern).format(date);
          });
        },
      ),
    );
  }
}

class TimePicker extends StatelessWidget {
  const TimePicker({
    Key? key,
    this.labelText,
    this.selectedTime,
    this.selectTime,
    this.fontSize,
  }) : super(key: key);

  final double? fontSize;
  final String? labelText;
  final TimeOfDay? selectedTime;
  final ValueChanged<TimeOfDay>? selectTime;

  Future _selectTime(BuildContext context) async {
    final picked = await showTimePicker(context: context, initialTime: selectedTime!);
    if (picked != null && picked != selectedTime) selectTime!(picked);
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.headline6;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: _InputDropdown(
            fontSize: fontSize,
            valueText: selectedTime!.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}
