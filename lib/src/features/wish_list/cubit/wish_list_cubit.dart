import 'package:fake_store/src/core/utils/service_locators.dart';
import 'package:fake_store/src/features/home/domain/product.dart';
import 'package:fake_store/src/features/wish_list/cubit/wish_list_state.dart';
import 'package:fake_store/src/features/wish_list/data/wish_list_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit() : super(WishListState());

  final WishListRepository _wishListRepository =
      getIt.get<WishListRepository>();

  void fetchWishListItems() async {
    List<Product> wishList = await _wishListRepository.fetchCachedWishList();

    emit(state.copyWith(wishList: wishList));
  }

  void removeWishListItem(Product product) async {
    await _wishListRepository.removeWishListItem(product);

    fetchWishListItems();
  }

  Future<void> addWishListItem(Product product) async {
    await _wishListRepository.addWishListItem(product);

    fetchWishListItems();
  }

  Future<bool> updateWishList(Product product) async {
    final bool productIsInWishList = checkIfProductIsInWishList(product);

    if (productIsInWishList) {
      removeWishListItem(product);
      return false;
    }
    await addWishListItem(product);
    return true;
  }

  bool checkIfProductIsInWishList(Product product) {
    try {
      state.wishList
          .firstWhere((wishListItem) => wishListItem.id == product.id);
      return true;
    } catch (_) {
      return false;
    }
  }
}
