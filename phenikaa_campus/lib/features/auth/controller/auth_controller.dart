import 'dart:html';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/apis/auth_api.dart';
import 'package:phenikaa_campus/apis/user_api.dart';
import 'package:phenikaa_campus/core/utils.dart';
import 'package:phenikaa_campus/features/auth/view/login_view.dart';
import 'package:phenikaa_campus/features/home/view/home_view.dart';
import 'package:phenikaa_campus/models/user_models.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    userAPI: ref.watch(userAPIProvider),
    authAPI: ref.watch(authAPIProvider),
  );
});
final currentUserAccountProvider = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController.currentUser();
  },
);

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);
  //isLoading
  Future<User?> currentUser() => _authAPI.currentUserAccount();
  //_account.get() != null ? HomeScreen : Login
  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
    );
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Account created! Please login.');
      Navigator.push(context, LoginView.route());
    });
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(
      email: email,
      password: password,
    );
    res.fold((l) => showSnackBar(context, l.message), (r) {
      Navigator.push(context, HomeView.route());
    });
  }

  Future<UserModel> getUserData (String uid){
  final Document = await _userAPI.getUserData(uid);
  final updateUser = UserModel.fromMap(document.data);
  return updateUser;
  }
} 
