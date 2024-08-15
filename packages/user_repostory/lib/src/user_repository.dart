import 'dart:async';
import 'package:user_repository/src/service/user_service.dart';
import 'package:user_repository/src/models/user.dart';

class UserRepository {
  UserModel? _user;
  final UserService _userService;

  UserRepository({
    required UserService userService,
  }) : _userService = userService;

  Future<UserModel?> getUser(String id) async {
    if (_user != null) return _user;
    _user = await _userService.getUser(id);
    return _user;
  }

  Future<void> addUser(String id, {Map<String, dynamic>? data}) async {
    await _userService.addUser(id, data: data);
  }
}