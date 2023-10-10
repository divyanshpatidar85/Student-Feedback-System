import 'package:flutter/material.dart';
import 'package:studentfeedbackform/resourcses.dart/auth_method.dart';

import 'package:studentfeedbackform/widget/alertdialog.dart';

class AdminFacUi extends StatelessWidget {
  final String name;
  final String uid;
  final String fcode;
  final String em;

  const AdminFacUi(
      {super.key,
      required this.name,
      required this.fcode,
      required this.uid,
      required this.em});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenSize.width * 0.8,
                child: Text(
                  'Faculty Name: $name',
                  maxLines: 4,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: screenSize.height * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FontMain1'),
                  softWrap: true,
                ),
              ),
              Text(
                'Faculty Code $fcode',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: screenSize.height * 0.03,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'FontMain3'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: const Icon(Icons.delete),
                onTap: () async {
                  String s =
                      await AuthMethods().deleteFacultyAdmin(fcode, uid, em);
                  alterDiallog(context, s);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
