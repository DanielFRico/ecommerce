sealed class FormProductEvent {}

final class NameChangedEvent extends FormProductEvent {
  final String name;
  NameChangedEvent({required this.name});
}

final class PriceChangedEvent extends FormProductEvent {
  final String price;
  PriceChangedEvent({required this.price});
}

final class UrlImageChangedEvent extends FormProductEvent {
  final String urlImage;
  UrlImageChangedEvent({required this.urlImage});
}

final class SubmitEvent extends FormProductEvent {
  SubmitEvent();
}
