import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product _product;

  ProductCard({
    Key key,
    @required Product product,
  })  : assert(product != null),
        _product = product,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthConst = MediaQuery.of(context).size.width / 360;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000000).withAlpha(30),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(
                2.0,
                5.0,
              ),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 13,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: widthConst * 107.0,
                      child: _product.mediaCollections != null &&
                              _product.mediaCollections.length > 0
                          ? ExtendedImage.network(
                              _product.mediaCollections[0].fullPathS3,

                              fit: BoxFit.fitWidth,
                              cache: true,

                              //cancelToken: cancellationToken,
                            )
                          : Image.asset("assets/images/dump/4@3x.png"),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        _product.name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansCJKkr-Medium",
                          fontStyle: FontStyle.normal,
                          fontSize: widthConst * 9.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
