import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterapp/common/env.dart';
import 'package:flutterapp/common/error_message.dart';
import 'package:flutterapp/user_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final Dio _dio;
  final String _endpoint = environment['baseUrl'];

  AuthenticationBloc({
    @required UserRepository userRepository,
    @required Dio dio,
  })  : assert(dio != null),
        _dio = dio,
        assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }

  Future<dynamic> get(String url) async {
    print("]-----] AuthenticationBloc::get call[-----[");
    try {
      String accessToken = await _userRepository.getAccessToken();
      _dio.options.headers = {
        "Authorization": accessToken,
        'Content-Type': 'application/json;charset=UTF-8',
      };
      final Response response = await _dio.get(_endpoint + url);
      return response.data;
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (error) {
      _handleError(error);
    }
  }

  Future<dynamic> post(String url, String body) async {
    print("]-----] AuthenticationBloc::post call[-----[");
    try {
      String accessToken = await _userRepository.getAccessToken();
      _dio.options.headers = {
        "Authorization": accessToken,
        'Content-Type': 'application/json;charset=UTF-8',
      };
      final Response response = await _dio.post(_endpoint + url, data: body);
      return response.data;
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (error) {
      _handleError(error);
    }
  }

  Future<dynamic> postformdata(String url, FormData formData) async {
    print("]-----] AuthenticationBloc::postformdata call[-----[");
    try {
      String accessToken = await _userRepository.getAccessToken();
      _dio.options.headers = {
        "Authorization": accessToken,
        'Content-Type': 'multipart/form-data;charset=UTF-8',
      };
      final Response response =
          await _dio.post(_endpoint + url, data: formData);
      return response.data;
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (error) {
      _handleError(error);
    }
  }

  Future<dynamic> put(String url, String body) async {
    print("]-----] AuthenticationBloc::put call[-----[");
    try {
      String accessToken = await _userRepository.getAccessToken();
      _dio.options.headers = {
        "Authorization": accessToken,
        'Content-Type': 'application/json;charset=UTF-8',
      };
      final Response response = await _dio.put(_endpoint + url, data: body);
      return response.data;
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (error) {
      _handleError(error);
    }
  }

  Future<dynamic> delete(String url) async {
    print("]-----] AuthenticationBloc::delete call[-----[");
    try {
      String accessToken = await _userRepository.getAccessToken();
      _dio.options.headers = {
        "Authorization": accessToken,
        'Content-Type': 'application/json;charset=UTF-8',
      };
      final Response response = await _dio.delete(_endpoint + url);
      return response.data;
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (error) {
      _handleError(error);
    }
  }

  Future<dynamic> basicAuth(String url, String basicToken) async {
    print("]-----] AuthenticationBloc::basicAuth call[-----[");
    try {
      _dio.options.headers = {
        "Authorization": basicToken,
        "Access-Control-Expose-Headers": "Authorization",
      };
      final Response response = await _dio.get(_endpoint + url);
      final data = response.headers;
      await _userRepository.persistToken(data.value('authorization'));
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (error) {
      _handleError(error);
    }
  }

  Future<dynamic> postWithoutAuth(String url, String body) async {
    print("]-----] AuthenticationBloc::basicAuth call[-----[");
    try {
      _dio.options.headers = {
        "Access-Control-Expose-Headers": "Authorization",
      };
      final Response response = await _dio.post(_endpoint + url, data: body);
      return response.data;
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (error) {
      _handleError(error);
    }
  }

  _handleDioError(DioError dioError) {
    print("]-----] AuthenticationBloc::error [-----[ $dioError");
    if (dioError.response != null) {
      print(
          "]-----] AuthenticationBloc::basicAuth.e.response.data [-----[ ${dioError.response.data}");
      print(
          "]-----] AuthenticationBloc::basicAuth.e.response.headers [-----[ ${dioError.response.headers}");
      print(
          "]-----] AuthenticationBloc::basicAuth.e.response.request [-----[ ${dioError.response.request}");
      if (dioError.response.statusCode == 401) {
        this.add(LoggedOut());
      } else {
        if (dioError.response.data['code'] != null) {
          throw Exception(
              ErrorMessage.getValue(dioError.response.data['code']));
        } else {
          throw Exception(dioError.response);
        }
      }
    } else {
      print(
          "]-----] AuthenticationBloc::basicAuth.e.request [-----[ ${dioError.request}");
      print(
          "]-----] AuthenticationBloc::basicAuth.e.message[-----[ ${dioError.message}");
    }
  }

  _handleError(error) {
    print("]-----] AuthenticationBloc::basicAuth.error [-----[ $error");
  }
}
