import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {
  final String email;
  final String password;

  LoginState({this.email = '', this.password = ''});

  LoginState copyWith({String? email, String? password});
}

class InitialState extends LoginState {
  InitialState({String email = '', String password = ''})
      : super(email: email, password: password);

  @override
  LoginState copyWith({String? email, String? password}) {
    return InitialState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class LoadingState extends LoginState {
  LoadingState({String email = '', String password = ''})
      : super(email: email, password: password);

  @override
  LoginState copyWith({String? email, String? password}) {
    return LoadingState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class LoginSuccessState extends LoginState {
  final User? user;

  LoginSuccessState(
      {required this.user, String email = '', String password = ''})
      : super(email: email, password: password);

  @override
  LoginState copyWith({String? email, String? password}) {
    return LoginSuccessState(
      user: user,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(
      {required this.error, String email = '', String password = ''})
      : super(email: email, password: password);

  @override
  LoginState copyWith({String? email, String? password}) {
    return LoginErrorState(
      error: error,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
