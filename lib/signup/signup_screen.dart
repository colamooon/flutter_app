import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/authentication_bloc/authentication_bloc.dart';
import 'package:flutterapp/common/screen_util.dart';

import 'bloc/bloc.dart';
import 'signup.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupBloc>(
      create: (context) => SignupBloc(
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '회원가입',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontFamily: "NotoSansCJKkr-Medium",
              fontSize: ScreenUtil().setSp(16),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SignupForm(),
      ),
    );
  }
}
