import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final Function(String) onSelect;
  final List<String> values;
  final String selected;

  const DropDown({
    Key? key,
    required this.onSelect,
    required this.values,
    required this.selected,
  }) : super(key: key);

  @override
  State<DropDown> createState() => _DropDrownState();
}

class _DropDrownState extends State<DropDown> {
  String value = "";

  @override
  void initState() {
    value = widget.values.contains(widget.selected)
        ? widget.selected
        : widget.values[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: DropdownButton<String>(
        value: value,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 6,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(
            () {
              value = newValue!;
            },
          );
          widget.onSelect(value);
        },
        items: widget.values.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
      ),
    );
  }
}
