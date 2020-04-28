import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/authentication_bloc/authentication_bloc.dart';

import 'bloc/bloc.dart';
import 'product.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
      child: Scaffold(
        body: ProductList(),
      ),
    );
  }
}
