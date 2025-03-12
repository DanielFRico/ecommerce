import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {
  final String email;
  final String password;
  final bool displayLoginError;

  LoginState(
      {this.email = '', this.password = '', this.displayLoginError = false});

  LoginState copyWith(
      {String? email, String? password, bool? displayLoginError});
}

class InitialState extends LoginState {
  InitialState(
      {String email = '', String password = '', bool displayLoginError = false})
      : super(
            email: email,
            password: password,
            displayLoginError: displayLoginError);

  @override
  LoginState copyWith(
      {String? email, String? password, bool? displayLoginError}) {
    return InitialState(
      email: email ?? this.email,
      password: password ?? this.password,
      displayLoginError: displayLoginError ?? this.displayLoginError,
    );
  }
}

class LoadingState extends LoginState {
  LoadingState(
      {String email = '', String password = '', bool displayLoginError = false})
      : super(
            email: email,
            password: password,
            displayLoginError: displayLoginError);

  @override
  LoginState copyWith(
      {String? email, String? password, bool? displayLoginError}) {
    return LoadingState(
      email: email ?? this.email,
      password: password ?? this.password,
      displayLoginError: displayLoginError ?? this.displayLoginError,
    );
  }
}

class LoginSuccessState extends LoginState {
  final User? user;

  LoginSuccessState(
      {required this.user,
      String email = '',
      String password = '',
      bool displayLoginError = false})
      : super(
            email: email,
            password: password,
            displayLoginError: displayLoginError);

  @override
  LoginState copyWith(
      {String? email, String? password, bool? displayLoginError}) {
    return LoginSuccessState(
      user: user,
      email: email ?? this.email,
      password: password ?? this.password,
      displayLoginError: displayLoginError ?? this.displayLoginError,
    );
  }
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(
      {required this.error,
      String email = '',
      String password = '',
      bool displayLoginError = false})
      : super(
            email: email,
            password: password,
            displayLoginError: displayLoginError);

  @override
  LoginState copyWith(
      {String? email, String? password, bool? displayLoginError}) {
    return LoginErrorState(
      error: error,
      email: email ?? this.email,
      password: password ?? this.password,
      displayLoginError: displayLoginError ?? this.displayLoginError,
    );
  }
}
