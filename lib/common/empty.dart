import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "",
      style: TextStyle(height: 0),
    );
  }
}
