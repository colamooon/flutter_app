import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/authentication_bloc/authentication_bloc.dart';
import 'package:flutterapp/common/empty.dart';
import 'package:flutterapp/common/screen_util.dart';
import 'package:flutterapp/signup/signup_agree.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'bloc/bloc.dart';
import 'email_verification_input.dart';
import 'signup.dart';

class SignupForm extends StatefulWidget {
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  AuthenticationBloc _authenticationBloc;
  SignupBloc _signupBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      _yearController.text.isNotEmpty &&
      _gender != null &&
      _gender.isNotEmpty &&
      _agreeService &&
      _agreeSecurity;

  bool isSignupButtonEnabled(SignupState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _signupBloc = BlocProvider.of<SignupBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
    _yearController.addListener(_onYearChanged);
  }

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  _setShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  _setShowConfirmPassword() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  bool _agreeAll = false;
  bool _agreeService = false;
  bool _agreeSecurity = false;
  bool _agreeMarketing = false;

  _setAgreeAll(bool value) {
    setState(() {
      _agreeAll = value;
    });
  }

  _setAgreeService(service) {
    setState(() {
      _agreeService = service;
    });
  }

  _setAgreeSecurity(security) {
    setState(() {
      _agreeSecurity = security;
    });
  }

  _setAgreeMarketing(marketing) {
    setState(() {
      _agreeMarketing = marketing;
    });
  }

  String _gender;

  _setGender(gender) {
    setState(() {
      _gender = gender;
    });
  }

  bool _isLoading = false;
  bool _isVerifyRequestSuccess = false;
  bool _isEmailEnable = true;
  bool _isVerified = false;
  String _verifiedEmail;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) async {
        if (state.isSuccess) {
          bool popResult = await _moveSigninScreen();
          print("]-----] popResult [-----[ ${popResult}");
          if (popResult) {
            Navigator.of(context).pop();
          }
        }
        if (state.isSubmitting) {
          setState(() {
            _isLoading = state.isSubmitting;
          });
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${state.failureMessage}'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return LoadingOverlay(
            isLoading: _isLoading,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(20),
                    bottom: ScreenUtil().setWidth(20),
                    left: ScreenUtil().setWidth(12),
                    right: ScreenUtil().setWidth(12),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
//                      margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 5.0, // soften the shadow
                              spreadRadius: 0.5, //extend the shadow
                              offset: Offset(
                                0.0, // Move to right 10  horizontally
                                0.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  TextFormField(
                                    controller: _emailController,
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
                                    autovalidate: true,
                                    autocorrect: false,
//                                    enabled: _isEmailEnable,
                                    validator: (_) {
                                      return !state.isEmailValid
                                          ? '올바른 이메일 형식이 아닙니다'
                                          : null;
                                    },
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSansCJKkr-Regular",
                                      fontSize: ScreenUtil().setSp(12),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 10,
                                    child: state.isEmailValid &&
                                            _emailController.text.isNotEmpty
                                        ? InkWell(
                                            onTap: () async {
                                              if (!_isLoading) {
                                                _sendVerificationNumber();
                                              }
                                            },
                                            child: Container(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              padding: const EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  top: 6,
                                                  bottom: 6),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "이메일 확인",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          "NotoSansCJKkr-Medium",
                                                      fontSize: ScreenUtil()
                                                          .setSp(10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : EmptyWidget(),
                                  )
                                ],
                              ),
                              _isVerifyRequestSuccess
                                  ? Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: EmailVerificationInput(),
                                    )
                                  : EmptyWidget(),
                              Container(
                                  margin: const EdgeInsets.only(bottom: 15.0)),
                              Stack(
                                children: <Widget>[
                                  TextFormField(
                                    controller: _passwordController,
                                    maxLength: 30,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      isDense: true,
                                      labelText: '비밀번호',
                                    ),
                                    obscureText: !_showPassword,
                                    autovalidate: true,
                                    autocorrect: false,
                                    validator: (_) {
                                      return !state.isPasswordValid
                                          ? '영문 대, 소문자, 숫자가 포함된 8~25자리가 아닙니다'
                                          : null;
                                    },
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSansCJKkr-Regular",
                                      fontSize: ScreenUtil().setSp(12),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                      iconSize: 15,
                                      color: Colors.black38,
                                      icon: _showPassword
                                          ? FaIcon(FontAwesomeIcons.eye)
                                          : FaIcon(FontAwesomeIcons.eyeSlash),
                                      onPressed: _setShowPassword,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(bottom: 15.0)),
                              Stack(
                                children: <Widget>[
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    maxLength: 30,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      isDense: true,
                                      labelText: '비밀번호 확인',
                                    ),
                                    obscureText: !_showConfirmPassword,
                                    autovalidate: true,
                                    autocorrect: false,
                                    validator: (_) {
                                      return !state.isConfirmPasswordValid
                                          ? '비밀번호가 일치하지 않습니다'
                                          : null;
                                    },
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSansCJKkr-Regular",
                                      fontSize: ScreenUtil().setSp(12),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                      iconSize: 15,
                                      color: Colors.black38,
                                      icon: _showConfirmPassword
                                          ? FaIcon(FontAwesomeIcons.eye)
                                          : FaIcon(FontAwesomeIcons.eyeSlash),
                                      onPressed: _setShowConfirmPassword,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(bottom: 15.0)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 5.0, // soften the shadow
                              spreadRadius: 0.5, //extend the shadow
                              offset: Offset(
                                0.0, // Move to right 10  horizontally
                                0.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              controller: _yearController,
                              maxLength: 4,
                              decoration: InputDecoration(
                                counterText: "",
                                isDense: true,
                                labelText: '태어난 해',
                                hintText: "1990",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSansCJKkr-Regular",
                                ),
                              ),
                              autovalidate: true,
                              autocorrect: false,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: "NotoSansCJKkr-Regular",
                                fontSize: ScreenUtil().setSp(12),
                              ),
                              validator: (_) {
                                return !state.isYearValid
                                    ? '잘못된 날짜 형식 입니다.'
                                    : null;
                              },
                            ),
                            Container(
                                margin: const EdgeInsets.only(bottom: 20.0)),
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "성별",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSansCJKkr-Regular",
                                      fontSize: ScreenUtil().setSp(12),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
//                              color: Colors.amber,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        IconButton(
                                          icon: FaIcon(FontAwesomeIcons.male),
                                          iconSize: 30,
                                          color: _gender == 'MALE'
                                              ? Theme.of(context).primaryColor
                                              : Colors.black45,
                                          onPressed: () {
                                            _setGender("MALE");
                                          },
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          child: IconButton(
                                            icon:
                                                FaIcon(FontAwesomeIcons.female),
                                            iconSize: 30,
                                            color: _gender == 'FEMALE'
                                                ? Theme.of(context).primaryColor
                                                : Colors.black45,
                                            onPressed: () {
                                              _setGender("FEMALE");
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 5.0, // soften the shadow
                              spreadRadius: 0.5, //extend the shadow
                              offset: Offset(
                                0.0, // Move to right 10  horizontally
                                0.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                        ),
                        child: SignupAgree(
                          setAgreeAll: _setAgreeAll,
                          setAgreeService: _setAgreeService,
                          setAgreeSecurity: _setAgreeSecurity,
                          setAgreeMarketing: _setAgreeMarketing,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: isSignupButtonEnabled(state)
                                  ? RaisedButton(
                                      onPressed: _onFormSubmitted,
//                                  elevation: 5.0,
                                      color: Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        '회원가입',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NotoSansCJKkr-Bold",
                                          fontSize: ScreenUtil().setSp(12),
                                        ),
                                      ),
                                    )
                                  : RaisedButton(
                                      onPressed: () {},
//                                  elevation: 5.0,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        '회원가입',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "NotoSansCJKkr-Medium",
                                          fontSize: ScreenUtil().setSp(12),
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
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _signupBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signupBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onConfirmPasswordChanged() {
    _signupBloc.add(
      ConfirmPasswordChanged(
          confirmPassword: _confirmPasswordController.text,
          password: _passwordController.text),
    );
  }

  void _onYearChanged() {
    _signupBloc.add(
      YearChanged(year: _yearController.text),
    );
  }

  void _onFormSubmitted() {
    _signupBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        birthyear: _yearController.text,
        gender: _gender,
        agreeService: _agreeService,
        agreeSecurity: _agreeSecurity,
        agreeMarketing: _agreeMarketing,
      ),
    );
  }

  _sendVerificationNumber() async {
    print("]-----] _sendVerificationNumber call[-----[");
    try {
      setState(() {
        _isLoading = true;
      });
      String body = json.encode({
        "email": _emailController.text,
      });
      final response = await _authenticationBloc.postWithoutAuth(
          '/auth/v1/verifyemail/request', body);
      print("]-----] _sendVerificationNumber response[-----[ ${response}");
      if (response != null) {
        setState(() {
          _isVerifyRequestSuccess = true;
          _isEmailEnable = false;
        });
      }
    } catch (error) {
      print("]-----] _sendVerificationNumber error[-----[ ${error}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _moveSigninScreen() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0))),
          contentPadding: EdgeInsets.all(5.0),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '회원가입이 성공하였습니다',
                        style: TextStyle(
                          fontFamily: 'NotoSansCJKkr-Bold',
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: -0.35,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Container(
                  height: 34,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context, true);
                          },
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              '확인',
                              style: TextStyle(
                                fontFamily: 'NotoSansCJKkr-Regular',
                                color: Colors.black,
                                fontSize: 12,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
