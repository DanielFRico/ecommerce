import 'package:ecommerce/app/home/presentation/model/home_model.dart';

sealed class HomeState {
  HomeState({required this.model});
  final HomeModel model;
}

final class EmptyState extends HomeState {
  EmptyState() : super(model: HomeModel(products: []));
}

final class LoadDataState extends HomeState {
  LoadDataState({required super.model});
}

final class LoadingState extends HomeState {
  final String message;
  LoadingState({this.message = "loading...., please wait"})
      : super(model: HomeModel(products: []));
}

final class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required super.model, required this.message});
}

final class LogoutState extends HomeState {
  LogoutState() : super(model: HomeModel(products: []));
}
