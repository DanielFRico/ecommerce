import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/app/login/presentation/bloc/login_bloc.dart';
import 'package:ecommerce/app/login/presentation/bloc/login_event.dart';
import 'package:ecommerce/app/login/presentation/bloc/login_state.dart';
import 'package:ecommerce/app/login/presentation/pages/login_mixin.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(FirebaseAuth.instance),
      child: const Scaffold(
        body: Column(
          children: [
            HeaderLoginWidget(),
            BodyLoginWidget(),
            FooterLoginWidget(),
          ],
        ),
      ),
    );
  }
}

class FooterLoginWidget extends StatelessWidget {
  const FooterLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Aún no tiene cuenta?"),
            const SizedBox(
              width: 8.0,
            ),
            GestureDetector(
              onTap: () => GoRouter.of(context).pushNamed("sign-up"),
              child: const Text(
                "Registrate acá",
                style: TextStyle(
                    color: Colors.orange,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.orange),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  const BodyLoginWidget({
    super.key,
  });

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> with LoginMixin {
  bool showPassword = false;
  Timer? autoShowTime;
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginSuccessState) {
          GoRouter.of(context).pushReplacementNamed("home");
        } else if (state is LoginErrorState && state.displayLoginError) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Error"),
              content: Text(state.error),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Aceptar"),
                ),
              ],
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final bool isValidForm = validateEmail(state.email) == null &&
              validatePassword(state.password) == null;
          return Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Form(
              key: keyForm,
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: state.email,
                    onChanged: (value) =>
                        bloc.add(EmailChangedEvent(email: value)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validateEmail,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Escriba tu email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: state.password,
                    onChanged: (value) =>
                        bloc.add(PasswordChangedEvent(password: value)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validatePassword,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Escriba tu Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          autoShowTime?.cancel();
                          if (!showPassword) {
                            autoShowTime =
                                Timer(const Duration(seconds: 3), () {
                              setState(() {
                                showPassword = false;
                              });
                            });
                          }
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed:
                        isValidForm ? () => bloc.add(SubmittedEvent()) : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: Colors.orange,
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Iniciar sesión",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://s3.amazonaws.com/cdn.hotglue.xyz/images/logos/firebase-auth.png",
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.contain,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "Inicio de Sesión",
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
