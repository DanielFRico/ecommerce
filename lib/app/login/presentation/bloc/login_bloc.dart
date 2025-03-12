import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth;

  LoginBloc(this._firebaseAuth) : super(InitialState()) {
    on<EmailChangedEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChangedEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SubmittedEvent>((event, emit) async {
      emit(LoadingState());
      try {
        UserCredential userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(
                email: 'danielrico953@gmail.com', password: '123456');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("login", true);
        emit(LoginSuccessState(user: userCredential.user));
      } catch (e) {
        print(e.toString());
        emit(LoginErrorState(error: e.toString()));
      }
    });
  }
}
