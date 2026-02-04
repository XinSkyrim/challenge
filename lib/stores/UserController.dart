import 'package:get/get.dart';
import 'package:flutter_challenge/viewmodels/user.dart';


class UserController extends GetxController {
  var user = UserInfo.fromJSON({}).obs;

  updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
