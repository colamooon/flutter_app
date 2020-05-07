import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [

    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: Image(
          image: AssetImage('assets/images/logos/heartit-logo-217x64.png'),
          width: ScreenUtil().setWidth(75),
        ),
        actions: <Widget>[
          InkResponse(
            child: Icon(Icons.view_headline),
            onTap: () {},
          ),
          VerticalDivider(
            indent: 20,
            endIndent: 20,
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: InkResponse(
              child: Icon(
                Icons.apps,
                color: Color.fromRGBO(204, 204, 204, 1),
              ),
              onTap: () {},
            ),
          )
        ],
        bottom: PreferredSize(
            child: Container(
              color: Color.fromRGBO(204, 204, 204, 1),
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(child: Text('Home!')),
            ],
          ),
        ),
      ),
    );
  }
}
