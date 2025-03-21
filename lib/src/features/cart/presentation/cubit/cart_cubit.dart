import 'package:fake_store/src/core/utils/service_locators.dart';
import 'package:fake_store/src/features/cart/data/repository/cart_repository.dart';
import 'package:fake_store/src/features/cart/domain/cart_item.dart';
import 'package:fake_store/src/features/cart/presentation/cubit/cart_state.dart';
import 'package:fake_store/src/features/home/domain/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  void fetchCartItems() async {
    List<CartItem> cartItems =
        await getIt.get<CartRepository>().fetchCachedCartItems();

    emit(state.copyWith(cartItems: cartItems));
  }

  void removeCartItem(Product product) async {
    await getIt.get<CartRepository>().removeCartItem(product);

    fetchCartItems();
  }

  Future<void> setCartItem(Product product,
      {bool reduceQuantity = false}) async {
    await getIt
        .get<CartRepository>()
        .setCartItem(product, reduceQuantity: reduceQuantity);

    fetchCartItems();
  }
}
