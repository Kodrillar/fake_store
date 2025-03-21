import 'dart:convert';

import 'package:fake_store/src/features/home/domain/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  int get id => product.id;
  double get totalPrice =>
      double.tryParse((product.price * quantity).toStringAsFixed(2)) ?? 0;

  @override
  String toString() => 'CartItem(product: $product, quantity: $quantity)';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'product': product.toMap()});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.product == product &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
