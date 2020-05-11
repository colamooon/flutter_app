import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterapp/common/screen_util.dart';

class HomeMainCard extends StatelessWidget {
  HomeMainCard({Key key}) : super(key: key);

  final _pageController = PageController();
  var rand = new Random();
  List<Widget> _pages = [
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dump/rfhfmwivmosqu6vaidlf.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(""),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dump/t4ix3nb5o8u2enmsbuup.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(""),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dump/zjjn57dusixnqiuewkkh.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(""),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key("saa" + rand.nextInt(33).toString()),
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 18,
                        backgroundImage:
                            AssetImage('assets/images/dump/seo_kyung.jpeg'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("seo_kyung"),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    "May 10th 2020",
                    style: TextStyle(
                      color: Color.fromRGBO(144, 144, 144, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansCJKkr-Regular",
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 240,
            child: PageView(
              controller: _pageController,
              physics: AlwaysScrollableScrollPhysics(),
              children: _pages,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
