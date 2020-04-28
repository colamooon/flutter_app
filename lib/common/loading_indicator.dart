import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: 33,
          height: 33,
          color: Colors.transparent,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey.withOpacity(0.5),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
        ),
      );
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
//            strokeWidth: 1.5,
            backgroundColor: Colors.grey.withOpacity(0.5),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
        ),
      ),
    );
  }
}
