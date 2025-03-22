import 'dart:convert';

import 'package:fake_store/src/core/utils/service_locators.dart';
import 'package:fake_store/src/features/cart/domain/cart_item.dart';
import 'package:fake_store/src/features/home/domain/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final SharedPreferences _sharedPreferences = getIt.get<SharedPreferences>();

  final _cartStorageKey = 'cart';

  Future<void> clearCart() async =>
      await _sharedPreferences.remove(_cartStorageKey);

  Future<List<CartItem>> fetchCachedCartItems() async {
    final encodedCartItems = _sharedPreferences.getString(_cartStorageKey);

    if (encodedCartItems != null) {
      final cartItemsMap = _decodeCartItemsString(encodedCartItems);

      List<CartItem> cartItems = cartItemsMap.map(CartItem.fromMap).toList();
      return cartItems;
    }
    return [];
  }

  Future<void> removeCartItem(Product product) async {
    final encodedCartItems = _sharedPreferences.getString(_cartStorageKey);

    final cartItemsMap = _decodeCartItemsString(encodedCartItems!);

    List<CartItem> cartItems = cartItemsMap.map(CartItem.fromMap).toList();

    final CartItem? cartItem = _findCartItem(product.id, cartItems);

    if (cartItem != null) {
      cartItems.remove(cartItem);

      final cartItemsMap =
          cartItems.map((cartItem) => cartItem.toMap()).toList();

      _storeCartItemsAsString(jsonEncode(cartItemsMap));
    }
  }

  Future<void> setCartItem(Product product, {reduceQuantity = false}) async {
    final encodedCartItems = _sharedPreferences.getString(_cartStorageKey);

    if (encodedCartItems != null) {
      final cartItemsMap = _decodeCartItemsString(encodedCartItems);

      List<CartItem> cartItems = cartItemsMap.map(CartItem.fromMap).toList();

      final CartItem? cartItem = _findCartItem(product.id, cartItems);

      if (cartItem != null) {
        final int cartItemIndex = cartItems.indexOf(cartItem);
        final updatedCartItem =
            _updateCartItemQuantity(cartItem, reduceQuantity: reduceQuantity);

        cartItems
            .replaceRange(cartItemIndex, cartItemIndex + 1, [updatedCartItem]);

        final cartItemsMap =
            cartItems.map((cartItem) => cartItem.toMap()).toList();

        _storeCartItemsAsString(jsonEncode(cartItemsMap));
        return;
      }

      cartItems.add(CartItem(product: product, quantity: 1));

      final updatedCartItems =
          cartItems.map((cartItem) => cartItem.toMap()).toList();

      _storeCartItemsAsString(jsonEncode(updatedCartItems));

      return;
    }

    _storeCartItemsAsString(
        '[${CartItem(product: product, quantity: 1).toJson()}]');
  }

  CartItem _updateCartItemQuantity(CartItem cartItem,
      {bool reduceQuantity = false}) {
    const int minimumCartItemQuantity = 1;

    if (reduceQuantity) {
      return cartItem.quantity > minimumCartItemQuantity
          ? cartItem.copyWith(quantity: cartItem.quantity - 1)
          : cartItem;
    }

    return cartItem.copyWith(quantity: cartItem.quantity + 1);
  }

  List<Map<String, dynamic>> _decodeCartItemsString(String cartItemsString) =>
      List<Map<String, dynamic>>.from(jsonDecode(cartItemsString));

  void _storeCartItemsAsString(String cartItemsJson) =>
      _sharedPreferences.setString(_cartStorageKey, cartItemsJson);

  CartItem? _findCartItem(int id, List<CartItem> cartItems) {
    try {
      return cartItems.firstWhere(
        (cartItem) => cartItem.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}
