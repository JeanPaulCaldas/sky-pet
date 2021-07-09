import 'package:sky_pet/data/models/user_model.dart';

abstract class LoginLocalDataSource {
  Future<UserModel> emailLogin(String email, String password);
}
