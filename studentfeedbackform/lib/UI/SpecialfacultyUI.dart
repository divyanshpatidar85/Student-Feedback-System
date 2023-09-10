import 'package:flutter/material.dart';
import 'package:studentfeedbackform/resourcses.dart/firestore_methods.dart';
import 'package:studentfeedbackform/widget/alertdialog.dart';

class FacUi extends StatefulWidget {
  final String fname;
  final String fid;
  final String cid;
  FacUi({
    required this.fname,
    required this.fid,
    required this.cid,
  });

  @override
  State<FacUi> createState() => _FacUiState();
}

class _FacUiState extends State<FacUi> {
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
                  'Faculty Name: ${widget.fname}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
              ),
              Text(
                'Faculty Name: ${widget.fid}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                child: const Icon(Icons.delete),
                onTap: () async {
                  String s =
                      await FireStoreMethods().deleteFacultyMember(widget.fid);
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
