import 'package:ecommerce/app/login/domain/entity/login_entity.dart';

final class LoginFormModel {
  final String email;
  final String password;

  LoginFormModel({
    required this.email,
    required this.password,
  });

  LoginFormModel copyWith({
    String? email,
    String? password,
  }) {
    return LoginFormModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  LoginEntity toEntity() => LoginEntity(
        email: email,
        password: password,
      );
}
