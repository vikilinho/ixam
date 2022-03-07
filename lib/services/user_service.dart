import 'package:get/get_connect.dart';
import 'package:ixam/models/constants.dart';
import 'package:ixam/models/login.dart';

class UserService extends GetConnect {
  Future<Response> login(Login login) async {
    Response response = await post('$BASE_URL/Auth/Login', login.toJson());
    return response;
  }
}
