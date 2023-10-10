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
      child: SizedBox(
        width: screenSize.width * 0.97,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenSize.width * 0.75,
                  child: Text(
                    'Faculty Name: ${widget.fname}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenSize.height * 0.04,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FontMain1'),
                    softWrap: true,
                  ),
                ),
                Text(
                  'Faculty Code: ${widget.fid}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: screenSize.height * 0.03,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'FontMain3'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  child: Text(
                    'Delete',
                    style: TextStyle(
                        fontFamily: 'FontMain1',
                        fontSize: screenSize.height * 0.02),
                  ),
                  onPressed: () async {
                    String s = await FireStoreMethods()
                        .deleteFacultyMember(widget.fid);
                    alterDiallog(context, s);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
