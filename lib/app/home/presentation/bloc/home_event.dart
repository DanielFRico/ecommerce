sealed class HomeEvent {}

final class GetProductsEvent extends HomeEvent {
  GetProductsEvent();
}

final class DeleteProductEvent extends HomeEvent {
  final String id;
  DeleteProductEvent({required this.id});
}

final class LogoutEvent extends HomeEvent {
  LogoutEvent();
}
