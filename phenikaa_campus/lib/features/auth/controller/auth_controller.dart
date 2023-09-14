import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/apis/auth_api.dart';
import 'package:phenikaa_campus/core/utils.dart';
import 'package:phenikaa_campus/features/auth/view/home_view.dart';
import 'package:phenikaa_campus/features/auth/view/login_view.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, dynamic>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
  );
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);
  //isLoading

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
}
