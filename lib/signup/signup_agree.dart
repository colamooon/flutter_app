import 'package:flutter/material.dart';
import 'package:flutterapp/termsofuse/marketing.dart';
import 'package:flutterapp/termsofuse/privacy_statement.dart';
import 'package:flutterapp/termsofuse/service_term_of_use.dart';

class SignupAgree extends StatefulWidget {
  Function _setAgreeAll;
  Function _setAgreeService;
  Function _setAgreeSecurity;
  Function _setAgreeMarketing;

  SignupAgree({
    Key key,
    @required Function setAgreeAll,
    @required Function setAgreeService,
    @required Function setAgreeSecurity,
    @required Function setAgreeMarketing,
  })  : assert(setAgreeAll != null),
        _setAgreeAll = setAgreeAll,
        assert(setAgreeService != null),
        _setAgreeService = setAgreeService,
        assert(setAgreeSecurity != null),
        _setAgreeSecurity = setAgreeSecurity,
        assert(setAgreeMarketing != null),
        _setAgreeMarketing = setAgreeMarketing,
        super(key: key);

  State<SignupAgree> createState() => _SignupAgreeState();
}

class _SignupAgreeState extends State<SignupAgree> {
  Function get _setAgreeAll => widget._setAgreeAll;

  Function get _setAgreeService => widget._setAgreeService;

  Function get _setAgreeSecurity => widget._setAgreeSecurity;

  Function get _setAgreeMarketing => widget._setAgreeMarketing;

  @override
  void initState() {
    super.initState();
  }

  bool _agreeAll = false;
  bool _agreeService = false;
  bool _agreeSecurity = false;
  bool _agreeMarketing = false;

  _setCheckAll(bool service, bool security, bool marketing) {
    if (service && security) {
      if (service && security && marketing) {
        setState(() {
          _agreeAll = true;
        });
      } else {
        setState(() {
          _agreeAll = false;
        });
      }
      _setAgreeAll(true);
    } else {
      setState(() {
        _agreeAll = false;
      });
      _setAgreeAll(false);
    }

    _setAgreeService(service);
    _setAgreeSecurity(security);
    _setAgreeMarketing(marketing);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Stack(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: Text(
                  "전체동의",
                  style: TextStyle(
                    color: _agreeAll
                        ? Theme.of(context).primaryColor
                        : Colors.black45,
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansCJKkr-Regular",
                    fontSize: 14.0,
                  ),
                ),
              ),
              Positioned(
                top: -10,
                right: -10,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Color.fromRGBO(155, 155, 155, 1),
                  ),
                  child: Transform.scale(
                    scale: 0.9,
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: _agreeAll,
                      activeColor: Theme.of(context).primaryColor,
//                checkColor: Color.fromRGBO(155, 155, 155, 1),
                      onChanged: (bool value) {
                        setState(() {
                          _agreeAll = value;
                          if (value) {
                            _agreeService = true;
                            _agreeSecurity = true;
                            _agreeMarketing = true;
                            _setCheckAll(true, true, true);
                          } else {
                            _agreeService = false;
                            _agreeSecurity = false;
                            _agreeMarketing = false;
                            _setCheckAll(false, false, false);
                          }
                        });
                        _setAgreeAll(value);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "서비스 이용약관 동의 (필수)",
                      style: TextStyle(
                        color: _agreeService
                            ? Theme.of(context).primaryColor
                            : Color.fromRGBO(155, 155, 155, 1),
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSansCJKkr-Regular",
                        fontSize: 11.0,
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Color.fromRGBO(155, 155, 155, 1),
                      ),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: _agreeService,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (bool value) {
                              setState(() {
                                _agreeService = value;
                              });
                              _setCheckAll(
                                  value, _agreeSecurity, _agreeMarketing);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 0.5,
                        color: Color.fromRGBO(155, 155, 155, 1),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ServiceTermOfUse(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "개인정보 취급방침 동의 (필수)",
                      style: TextStyle(
                        color: _agreeSecurity
                            ? Theme.of(context).primaryColor
                            : Color.fromRGBO(155, 155, 155, 1),
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSansCJKkr-Regular",
                        fontSize: 11.0,
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Color.fromRGBO(155, 155, 155, 1),
                      ),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: _agreeSecurity,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (bool value) {
                              setState(() {
                                _agreeSecurity = value;
                              });
                              _setCheckAll(
                                  _agreeService, value, _agreeMarketing);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 0.5,
                        color: Color.fromRGBO(155, 155, 155, 1),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PrivacyStatement(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "마케팅 정보 수신 동의 (선택)",
                      style: TextStyle(
                        color: _agreeMarketing
                            ? Theme.of(context).primaryColor
                            : Color.fromRGBO(155, 155, 155, 1),
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSansCJKkr-Regular",
                        fontSize: 11.0,
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Color.fromRGBO(155, 155, 155, 1),
                      ),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: _agreeMarketing,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (bool value) {
                              setState(() {
                                _agreeMarketing = value;
                              });
                              _setCheckAll(
                                  _agreeService, _agreeSecurity, value);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 0.5,
                        color: Color.fromRGBO(155, 155, 155, 1),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Marketing(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
