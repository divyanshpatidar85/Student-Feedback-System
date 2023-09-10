import 'package:flutter/material.dart';

class DropdownMenuu extends StatelessWidget {
  final List<String> sem = [
    'sem',
    'i',
    'ii',
    'iii',
    'iv',
    'v',
    'vi',
    'vii',
    'viii',
    'ix',
    'x'
  ];
  final String selectedOption;
  var onChangd;

  DropdownMenuu({required this.selectedOption, required this.onChangd});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedOption,
      onChanged: onChangd,
      items: sem.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
