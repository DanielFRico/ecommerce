sealed class LoginEvent {}

final class EmailChangedEvent extends LoginEvent {
  final String email;

  EmailChangedEvent({required this.email});
}

final class PasswordChangedEvent extends LoginEvent {
  final String password;

  PasswordChangedEvent({required this.password});
}

final class SubmittedEvent extends LoginEvent {
  SubmittedEvent();
}
