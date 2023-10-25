import 'package:flutter/material.dart';
import 'package:studentfeedbackform/wideget.dart';
import 'package:studentfeedbackform/widget/alertdialog.dart';

class UpdateSemValue extends StatefulWidget {
  const UpdateSemValue({super.key});

  @override
  State<UpdateSemValue> createState() => _UpdateSemValueState();
}

class _UpdateSemValueState extends State<UpdateSemValue> {
  List<String> sem = [
    'sem',
    'i',
    'ii',
    'iii',
    'iv',
    'v',
    'vi',
    'vii',
    'viii',
  ];
  String selectedSem = 'i';
  String updatesem = 'sem';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Semsester Value'),
      ),
      body: Center(
          child: Column(
        children: [
          const Text('Old Sem'),
          DropdownButton<String>(
            value: selectedSem,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedSem = newValue;
                });
              }
            },
            items: sem.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Text('New Semester'),
          DropdownButton<String>(
            value: updatesem,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  updatesem = newValue;
                });
              }
            },
            items: sem.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
              onPressed: () async {
                String res = await updateDocuments(selectedSem, updatesem);
                alterDiallog(context, res);
              },
              child: const Text('Update'))
        ],
      )),
    );
  }
}
