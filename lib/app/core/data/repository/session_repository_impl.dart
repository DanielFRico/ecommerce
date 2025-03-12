import 'package:ecommerce/app/core/domain/repository/session_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SessionRepositoryImp implements SessionRepository {
  @override
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove("login");
  }
}
