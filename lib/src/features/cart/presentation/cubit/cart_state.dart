import 'package:fake_store/src/features/cart/domain/cart_item.dart';

class CartState {
  CartState({this.cartItems = const []});

  final List<CartItem> cartItems;

  double get cartTotal {
    double sum = 0;

    for (var cartItem in cartItems) {
      sum += cartItem.totalPrice;
    }

    return double.tryParse((sum).toStringAsFixed(2)) ?? 0;
  }

  CartState copyWith({
    List<CartItem>? cartItems,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
