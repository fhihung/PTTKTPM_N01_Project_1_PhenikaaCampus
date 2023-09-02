import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:phenikaa_campus/core/providers.dart';
// import 'package:appwrite/models.dart';
import '../core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// to signup, to get user account -> Account
// to access user related data -> User

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(
    account: account,
  );
});

abstract class IAuthAPI {
  FutureEither<User> signUp({
    required String email,
    required String password,
  });
  FutureEither<Session> logIn({
    required String email,
    required String password,
  });
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  FutureEither<User> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occured', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEither<Session> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.createEmailSession(
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occured', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
