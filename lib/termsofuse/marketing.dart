import 'package:flutter/material.dart';

class Marketing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("마케팅 정보 수신 동의",
                  style: const TextStyle(
                    color: Color.fromRGBO(155, 155, 155, 1),
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansCJKkr-Bold",
                    fontSize: 8.0,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
