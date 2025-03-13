import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/app/core/domain/use_case/logout_use_case.dart';
import 'package:ecommerce/app/home/domain/use_case/delete_product_use_case.dart';
import 'package:ecommerce/app/home/domain/use_case/get_products_use_case.dart';
import 'package:ecommerce/app/home/presentation/model/product_model.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final DeleteProductsUseCase deleteProductsUseCase;
  final LogoutUseCase logoutUseCase;

  HomeBloc({
    required this.getProductsUseCase,
    required this.deleteProductsUseCase,
    required this.logoutUseCase,
  }) : super(LoadingState()) {
    on<GetProductsEvent>(_getProductsEvent);

    on<DeleteProductEvent>((deleteProductEvent, emit) async {
      late HomeState newState;
      try {
        newState = LoadingState();
        emit(newState);
        final bool result =
            await deleteProductsUseCase.invoke(deleteProductEvent.id);
        if (result) {
          await _getProductsEvent(GetProductsEvent(), emit);
        } else {
          throw Exception();
        }
      } catch (e) {
        newState = HomeErrorState(
          model: state.model,
          message: "Error deleting product",
        );
        if (!emit.isDone) emit(newState);
      }
    });

    on<LogoutEvent>((LogoutEvent event, emit) async {
      await logoutUseCase.invoke();
      if (!emit.isDone) emit(LogoutState());
    });
  }

  Future<void> _getProductsEvent(
      GetProductsEvent event, Emitter<HomeState> emit) async {
    late HomeState newState;
    try {
      newState = LoadingState();
      emit(newState);
      final List<ProductModel> result = await getProductsUseCase.invoke();
      if (result.isEmpty) {
        newState = EmptyState();
      } else {
        newState = LoadDataState(model: state.model.copyWith(products: result));
      }
    } catch (e) {
      newState = HomeErrorState(
        model: state.model,
        message: "Oops! Something wrong happened",
      );
    }
    if (!emit.isDone) emit(newState);
  }
}
