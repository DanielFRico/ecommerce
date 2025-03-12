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
            Text("Aún no tiene cuenta?"),
            const SizedBox(
              width: 32.0,
            ),
            GestureDetector(
              onTap: () => GoRouter.of(context).pushNamed("sign-up"),
              child: const Text(
                "Registrate acá",
                style: TextStyle(
                    color: Colors.purple,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.purple),
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
            margin: const EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
            child: Form(
              key: keyForm,
              child: Column(
                children: [
                  Text("Email: ${state.email} y password: ${state.password}"),
                  TextFormField(
                    initialValue: state.email,
                    onChanged: (value) =>
                        bloc.add(EmailChangedEvent(email: value)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validateEmail,
                    decoration: const InputDecoration(
                      labelText: "Email:",
                      prefixIcon: Icon(Icons.person),
                      hintText: "Escriba tu email",
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
                      labelText: "Password:",
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Escriba tu Password",
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
                  FilledButton(
                    onPressed:
                        isValidForm ? () => bloc.add(SubmittedEvent()) : null,
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Iniciar sesión",
                        textAlign: TextAlign.center,
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
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.fitWidth,
            "https://cdn11.bigcommerce.com/s-x49po/images/stencil/800w/products/89261/250190/legacy_products%2FART_3319_71084__04721.1722626542.jpg?c=2",
          ),
          Container(
            color: Colors.blue,
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
