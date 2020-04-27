import 'package:flutter/material.dart';
import 'package:flutterapp/common/screen_util.dart';

class EmailVerificationInput extends StatefulWidget {
  EmailVerificationInput({Key key}) : super(key: key);

  @override
  _EmailVerificationInputState createState() => _EmailVerificationInputState();
}

class _EmailVerificationInputState extends State<EmailVerificationInput> {
  final TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _numberController,
      maxLength: 30,
      decoration: InputDecoration(
        counterText: "",
        isDense: true,
        labelText: '이메일',
        hintText: "thevita@thevita.io",
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: "NotoSansCJKkr-Regular",
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      autovalidate: false,
      autocorrect: false,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: "NotoSansCJKkr-Regular",
        fontSize: ScreenUtil().setSp(12),
      ),
    );
  }
}
