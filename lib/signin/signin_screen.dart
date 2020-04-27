import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/authentication_bloc/authentication_bloc.dart';

import 'bloc/bloc.dart';
import 'signin.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SigninBloc>(
      create: (context) => SigninBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
//            Background(),
            SigninForm(),
          ],
        ),
      ),
    );
  }
}
