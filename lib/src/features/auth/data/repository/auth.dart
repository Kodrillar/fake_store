import 'package:fake_store/src/core/utils/service_locators.dart';
import 'package:fake_store/src/features/auth/data/network/auth.dart';
import 'package:fake_store/src/features/auth/domain/login_data.dart';
import 'package:fake_store/src/features/cart/data/repository/cart_repository.dart';
import 'package:fake_store/src/features/wish_list/data/wish_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<String?> authStateChangesNotifier = ValueNotifier<String?>(null);

class AuthRepository {
  final SharedPreferences _sharedPreferences = getIt.get<SharedPreferences>();

  final CartRepository _cartRepository = getIt<CartRepository>();

  final WishListRepository _wishListRepository = getIt<WishListRepository>();

  final String _authTokenKey = 'authTokenKey';

  Future<void> logIn(LoginData loginData) async {
    final String token = await getIt.get<AuthNetworkHelper>().logIn(loginData);

    final bool isCached =
        await _sharedPreferences.setString(_authTokenKey, token);
    if (isCached) authStateChangesNotifier.value = token;
  }

  void initializeCurrentUser() {
    final String? token = _sharedPreferences.get(_authTokenKey) as String?;

    if (token != null) authStateChangesNotifier.value = token;
  }

  Future<void> logOut() async {
    await Future.wait([
      _sharedPreferences.remove(_authTokenKey),
      _cartRepository.clearCart(),
      _wishListRepository.clearWishList(),
    ]);

    authStateChangesNotifier.value = null;
  }
}
