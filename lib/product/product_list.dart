import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/authentication_bloc/authentication_bloc.dart';
import 'package:flutterapp/common/loading_indicator.dart';
import 'package:flutterapp/common/screen_util.dart';
import 'package:flutterapp/model/product.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'bloc/bloc.dart';
import 'product.dart';

class ProductList extends StatefulWidget {
  ProductList({Key key}) : super(key: key);

  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ProductBloc _productBloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _scrollController.addListener(_onScroll);
    _productBloc.add(ProductsLoad());
  }

  List<Product> _products;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state.isLoaded) {
          setState(() {
            _products = state.products;
          });
        }
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return LoadingOverlay(
            isLoading: state.isLoading,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(30),
                    bottom: ScreenUtil().setWidth(30),
                    left: ScreenUtil().setWidth(32),
                    right: ScreenUtil().setWidth(32),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 0.78,
                          children: List.generate(
                            _products != null
                                ? state.hasReachedMax
                                    ? _products.length
                                    : _products.length + 1
                                : 0,
                            (index) => index >= _products.length
                                ? BottomLoader()
                                : ProductCard(
                                    product: _products[index],
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _productBloc.add(ProductsLoad());
    }
  }
}
