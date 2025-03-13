import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ecommerce/app/dependency_injection/di.dart';
import 'package:ecommerce/app/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:ecommerce/app/form_product/presentation/bloc/form_product_event.dart';
import 'package:ecommerce/app/form_product/presentation/bloc/form_product_state.dart';

class FormProductPage extends StatelessWidget {
  const FormProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<FormProductBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Agregar Producto"),
        ),
        body: Column(
          children: [
            BodyLoginWidget(),
          ],
        ),
      ),
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  const BodyLoginWidget({super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> {
  bool _showPassword = false;
  Timer? _autoShowTimer;
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormProductBloc>();

    return BlocListener<FormProductBloc, FormProductState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case SubmitSuccessState():
            GoRouter.of(context).pop();
            break;
          case SubmitErrorState():
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Error'),
                      content: Text(state.message),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ));
            break;
        }
      },
      child: BlocBuilder<FormProductBloc, FormProductState>(
        builder: (context, state) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    Text(state.model.name),
                    TextFormField(
                      onChanged: (value) =>
                          bloc.add(NameChangedEvent(name: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Name:",
                        icon: Icon(Icons.card_giftcard),
                        hintText: "Escribe el nombre del producto",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 32.0),
                    TextFormField(
                      initialValue: state.model.urlImage,
                      onChanged: (value) =>
                          bloc.add(UrlImageChangedEvent(urlImage: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Url:",
                        icon: Icon(Icons.image),
                        hintText: "Escribe la url del producto",
                      ),
                    ),
                    SizedBox(height: 32.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          bloc.add(PriceChangedEvent(price: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Precio:",
                        icon: Icon(Icons.attach_money),
                        hintText: "Escribe el precio del producto",
                      ),
                    ),
                    SizedBox(height: 48.0),
                    FilledButton(
                      onPressed: () => {bloc.add(SubmitEvent())},
                      child: SizedBox(
                        width: double.infinity,
                        child: Text("Crear", textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          // switch (state) {
          //   case DataUpdateState():
          //     print(state.model.email);
          //     break;

          //   default:
          // }
          // return Expanded(
          //   child: Container(
          //     color: Colors.amber,
          //     child: InkWell(child: Text("data"), onTap: () {
          //       bloc.add(EmailChangedEvent(email: "Cambio de email"));
          //     }),
          //   ),
          // );
        },
      ),
    );
  }
}
