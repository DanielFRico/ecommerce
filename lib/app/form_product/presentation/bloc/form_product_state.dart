import 'package:ecommerce/app/form_product/presentation/model/product_form_model.dart';

sealed class FormProductState {
  FormProductState({required this.model});

  final ProductFormModel model;
}

final class InitialState extends FormProductState {
  InitialState()
      : super(
            model: ProductFormModel(
                id: "",
                name: "",
                price: "",
                urlImage:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu2Mk8RvjN5Fj5kLR9sZ8kjDFNtW8xaTm27rds1KnWjqyXt_UG2styAxBH_2oUU45Ev5I&usqp=CAU"));
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
