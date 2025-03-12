import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth;

  LoginBloc(this._firebaseAuth) : super(InitialState()) {
    on<EmailChangedEvent>((event, emit) {
      emit(state.copyWith(email: event.email, displayLoginError: false));
    });

    on<PasswordChangedEvent>((event, emit) {
      emit(state.copyWith(password: event.password, displayLoginError: false));
    });

    on<SubmittedEvent>((event, emit) async {
      emit(LoadingState(email: state.email, password: state.password));
      try {
        UserCredential userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("login", true);
        emit(LoginSuccessState(
            user: userCredential.user,
            email: state.email,
            password: state.password));
      } catch (e) {
        emit(LoginErrorState(
            error: e.toString(),
            email: state.email,
            password: state.password,
            displayLoginError: true));
      }
    });
  }
}
