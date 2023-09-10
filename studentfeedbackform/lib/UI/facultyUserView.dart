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
                width: screenSize.width * 0.8,
                child: Text(
                  'Faculty Name: ${widget.fname}',
                  // maxLines: 3,

                  // overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FontMain1'),
                  softWrap: true,
                ),
              ),
              Text(
                'Faculty Code: ${widget.fid}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'FontMain2'),
              ),
            ],
          ),
          InkWell(
              onTap: () {
                print('$cid    $fid    ');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReviewScreen(
                              courseid: cid,
                              facultyid: fid,
                              iscourse: false,
                            )));
              },
              child: const Icon(Icons.rate_review))
        ],
      ),
    );
  }
}
