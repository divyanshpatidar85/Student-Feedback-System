import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:studentfeedbackform/UI/ReviewScreen.dart';

class UserFacUi extends StatefulWidget {
  final String fname;
  final String fid;
  final String cid;
  const UserFacUi({
    super.key,
    required this.fname,
    required this.fid,
    required this.cid,
  });

  @override
  State<UserFacUi> createState() => _UserFacUiState(fid: fid, cid: cid);
}

class _UserFacUiState extends State<UserFacUi> {
  final String fid;
  final String cid;

  _UserFacUiState({required this.fid, required this.cid});
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
              SizedBox(
                width: screenSize.width * 0.7,
                child: Text(
                  'Faculty Name: ${widget.fname}',
                  // maxLines: 3,

                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize:
                          kIsWeb && MediaQuery.of(context).size.width > 375
                              ? MediaQuery.of(context).size.height * 0.04
                              : MediaQuery.of(context).size.width * 0.07,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FontMain1'),
                  softWrap: true,
                  maxLines: 5,
                ),
              ),
              Text(
                'Faculty Code: ${widget.fid}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: kIsWeb && MediaQuery.of(context).size.width > 375
                        ? MediaQuery.of(context).size.height * 0.04
                        : MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'FontMain1'),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              print('$cid    $fid    ');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReviewScreen(
                            courseid: cid,
                            facultyid: fid,
                            iscourse: false,
                            coursename: widget.fname,
                          )));
            },
            child: const Text(
              "Rate Faculty",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'FontMain2',
              ),
              softWrap: true,
              maxLines: 3,
            ),
          )
        ],
      ),
    );
  }
}
