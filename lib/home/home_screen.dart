import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../common/screen_util.dart';
import 'home_main.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> pageList = <Widget>[
    HomeMain(),
    _SecondPage(),
    _ThirdPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: PageTransitionSwitcher(
        transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pageList[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
class _ExampleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Ink.image(
                        image: const AssetImage('assets/images/dump/placeholder_image.png'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '123 photos',
                        // TODO(shihaohong): Remove this once Flutter stable adopts the modern
                        // Material text style nomenclature.
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.body2,
                      ),
                      Text(
                        '123 photos',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              splashColor: Colors.black38,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _ExampleCard(),
              _ExampleCard(),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _ExampleCard(),
              _ExampleCard(),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _ExampleCard(),
              _ExampleCard(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _ExampleCard(),
        _ExampleCard(),
      ],
    );
  }
}

class _ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.asset(
            'assets/images/dump/avatar_logo.png',
            width: 40,
          ),
          title: Text('List item ${index + 1}'),
          subtitle: const Text('Secondary text'),
        );
      },
      itemCount: 10,
    );
  }
}
