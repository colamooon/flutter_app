import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterapp/authentication_bloc/authentication_bloc.dart';
import 'package:flutterapp/common/screen_util.dart';
import 'package:flutterapp/signup/signup_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'bloc/bloc.dart';

class SigninForm extends StatefulWidget {
  SigninForm({Key key}) : super(key: key);

  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SigninBloc _signinBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(SigninState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _signinBloc = BlocProvider.of<SigninBloc>(context);
    _emailController.addListener(_onEmailChanged);
//    _passwordController.addListener(_onPasswordChanged);
  }

  bool _showPassword = false;

  _setShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${state.failureMessage}'),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<SigninBloc, SigninState>(
        builder: (context, state) {
          return LoadingOverlay(
            isLoading: state.isSubmitting,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
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
//                      Container(
//                        padding: const EdgeInsets.all(20),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(5),
//                        ),
//                        child: SvgPicture.asset(
//                          'assets/images/logos/logo-icon-small.svg',
//                          width: ScreenUtil().setWidth(72),
//                          fit: BoxFit.fill,
//                        ),
//                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 50.0),
                        child: Center(
                          child: Icon(
                            Icons.headset_mic,
                            color: Colors.redAccent,
                            size: 80.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                          ? '올바른 비밀번호 형식이 아닙니다'
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
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: isLoginButtonEnabled(state)
                                  ? RaisedButton(
                                      onPressed: _onFormSubmitted,
//                                  elevation: 5.0,
                                      color: Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        '로그인',
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
                                        '로그인',
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
                      Container(
//                        color: Colors.white,
                        margin: EdgeInsets.only(top: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen()),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: 4, left: 2, right: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      //                   <--- left side
                                      color: Color.fromRGBO(155, 155, 155, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(right: 9.0),
                                child: Text(
                                  "회원가입",
                                  style: const TextStyle(
                                      color: Color.fromRGBO(155, 155, 155, 1),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSansCJKkr-Regular",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
//                            _moveAuthForMemberFind(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: EdgeInsets.only(
                                    bottom: 4, left: 2, right: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(155, 155, 155, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "비밀번호 찾기",
                                  style: const TextStyle(
                                      color: Color.fromRGBO(155, 155, 155, 1),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NotoSansCJKkr-Regular",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
//                      Background(),
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
    super.dispose();
  }

  void _onEmailChanged() {
    _signinBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signinBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _signinBloc.add(
      SigninWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
