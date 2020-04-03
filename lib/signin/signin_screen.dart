import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/authentication_bloc/authentication_bloc.dart';

import 'bloc/bloc.dart';
import 'signin.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  void initState() {
    super.initState();
  }

  PageController _pageController =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SigninBloc>(
      create: (context) => SigninBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
      child: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: _pageController,
              physics: new AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                SigninPage(),
                DefaultPage(
                  gotoSignin: _gotoSignin,
                  gotoSignup: _gotoSignup,
                ),
                SignupPage()
              ],
              scrollDirection: Axis.horizontal,
            )),
      ),
    );
  }

  _gotoSignin() {
    _pageController.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  _gotoSignup() {
    _pageController.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }
}
