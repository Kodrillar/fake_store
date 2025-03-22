import 'dart:convert';

import 'package:fake_store/src/core/utils/service_locators.dart';
import 'package:fake_store/src/features/home/domain/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishListRepository {
  final String _wishListStoreKey = 'wishlist';

  final SharedPreferences _sharedPreferences = getIt.get<SharedPreferences>();

  Future<void> clearWishList() async =>
      await _sharedPreferences.remove(_wishListStoreKey);

  Future<List<Product>> fetchCachedWishList() async {
    final encodedWishList = _sharedPreferences.getString(_wishListStoreKey);

    if (encodedWishList != null) {
      final wishListMap = _decodeWishListItemsString(encodedWishList);

      List<Product> wishList = wishListMap.map(Product.fromMap).toList();

      return wishList;
    }
    return List.empty();
  }

  Future<void> addWishListItem(Product product) async {
    final encodedWishList = _sharedPreferences.getString(_wishListStoreKey);

    if (encodedWishList != null) {
      final wishListItemsMap = _decodeWishListItemsString(encodedWishList);

      List<Product> wishList = wishListItemsMap.map(Product.fromMap).toList();

      final Product? wishListItem = _findWishListItem(product.id, wishList);

      if (wishListItem == null) {
        wishList.add(product);

        final updatedWishList =
            wishList.map((product) => product.toMap()).toList();

        _storeWishListAsString(jsonEncode(updatedWishList));
      }

      return;
    }

    _storeWishListAsString('[${jsonEncode(product.toMap())}]');
  }

  Future<void> removeWishListItem(Product product) async {
    final encodedWishList = _sharedPreferences.getString(_wishListStoreKey);

    final wishListMap = _decodeWishListItemsString(encodedWishList!);

    List<Product> wishList = wishListMap.map(Product.fromMap).toList();

    final Product? wishListItem = _findWishListItem(product.id, wishList);

    if (wishListItem != null) {
      wishList.remove(wishListItem);

      final wishListMap = wishList.map((product) => product.toMap()).toList();

      _storeWishListAsString(jsonEncode(wishListMap));
    }
  }

  void _storeWishListAsString(String wishListJson) =>
      _sharedPreferences.setString(_wishListStoreKey, wishListJson);

  List<Map<String, dynamic>> _decodeWishListItemsString(
          String wishListItemsString) =>
      List<Map<String, dynamic>>.from(jsonDecode(wishListItemsString));

  Product? _findWishListItem(int id, List<Product> wishList) {
    try {
      return wishList.firstWhere(
        (product) => product.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}
