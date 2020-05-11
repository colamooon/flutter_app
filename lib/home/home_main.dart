import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/authentication_bloc/authentication_bloc.dart';

import 'home_main_card.dart';
import 'homemain_bloc/bloc.dart';

class HomeMain extends StatelessWidget {
  HomeMain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeMainBloc>(
      create: (context) => HomeMainBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
      child: Container(
        color: Colors.white,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return HomeMainCard();
            }),
      ),
    );
  }
}
