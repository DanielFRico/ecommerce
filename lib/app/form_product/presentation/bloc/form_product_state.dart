import 'package:ecommerce/app/form_product/presentation/model/product_form_model.dart';

sealed class FormProductState {
  FormProductState({required this.model});

  final ProductFormModel model;
}

final class InitialState extends FormProductState {
  InitialState()
      : super(
            model: ProductFormModel(id: "", name: "", price: "", urlImage: ""));
}

final class DataUpdateState extends FormProductState {
  DataUpdateState({required super.model});
}

final class SubmitSuccessState extends FormProductState {
  SubmitSuccessState({required super.model});
}

final class SubmitErrorState extends FormProductState {
  SubmitErrorState({required super.model, required this.message});
  final String message;
}
