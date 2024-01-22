import 'package:carrot_flutter/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../connect/user_connect.dart';

final GetStorage _storage = GetStorage();

/**
 * 회원 동작과 관련된 모든 상태들을 공통으로 관리하는 클래스
 */
class UserController extends GetxController {
  // userConnect 객체 생성 (DI)
  final userConnection = Get.put(UserConnect());
  UserModel? user;

  // 로그인 되어있는 지 판단
  Future<bool> isLogin() async {
    return _storage.hasData('access_token');
  }

  // 회원 가입을 시도하는 함수
  Future<bool> register(String email, String name, String password) async {
    try {
      String token = await userConnection.sendRegister(email, name, password);
      _storage.write('access_token', token);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text('$e')));
      return false;
    }
  }

  // 로그인을 시도하는 함수
  Future login(String email, String password) async {
    try {
      String token = await userConnection.sendLogin(email, password);
      _storage.write('access_token', token);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text('$e')));
      return false;
    }
  }

  // 나의 정보를 가져오는 함수
  Future mypage() async {}
}
