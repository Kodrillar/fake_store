import 'package:fake_store/src/features/home/domain/product.dart';

class WishListState {
  WishListState({this.wishList = const []});

  final List<Product> wishList;

  WishListState copyWith({
    List<Product>? wishList,
  }) {
    return WishListState(
      wishList: wishList ?? this.wishList,
    );
  }
}
