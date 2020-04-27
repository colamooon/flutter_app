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
