import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/widgets/app_primary_button.dart';
import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/core/widgets/button_text.dart';
import 'package:fake_store/src/core/widgets/header_text.dart';
import 'package:fake_store/src/core/widgets/log_out_button.dart';
import 'package:fake_store/src/core/widgets/product_name_text.dart';
import 'package:fake_store/src/core/widgets/product_price_text.dart';
import 'package:fake_store/src/features/cart/domain/cart_item.dart';
import 'package:fake_store/src/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store/src/features/cart/presentation/cubit/cart_state.dart';
import 'package:fake_store/src/res/app_fonts.dart';
import 'package:fake_store/src/res/app_spacers.dart';
import 'package:fake_store/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:screendapt/screendapt.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return AppScaffold(
          body: Column(
            children: [
              const CartScreenAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: SContainer(
                    child: Column(
                      children: [
                        if (state.cartItems.isEmpty)
                          SText(
                            'Your Cart is currently empty!',
                            style:
                                TextStyle(color: context.appTheme.textAccent),
                          ),
                        for (CartItem cartItem in state.cartItems) ...[
                          CartProductCard(cartItem: cartItem),
                          Spacers.h25,
                        ]
                      ],
                    ),
                  ),
                ),
              ),
              CartScreenFooter(cartTotal: state.cartTotal)
            ],
          ),
        );
      },
    );
  }
}

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appTheme.error,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Icon(
            Icons.delete_outline,
            color: context.appTheme.background,
          ),
        ),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  const CartProductCard({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: const DismissibleBackground(),
      key: Key('${cartItem.id}'),
      onDismissed: (direction) =>
          context.read<CartCubit>().removeCartItem(cartItem.product),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //PRODUCT IMAGE
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: context.appTheme.textAccent.withOpacity(.3),
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: Image.network(cartItem.product.image).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Spacers.w10,

                //PRODUCT DETAILS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductNameText(cartItem.product.title),
                      Spacers.h10,
                      IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: context.appTheme.primary.withOpacity(.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => context
                                    .read<CartCubit>()
                                    .setCartItem(cartItem.product,
                                        reduceQuantity: true),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 13, right: 5),
                                  child: CartItemUpdateButton(Icons.remove),
                                ),
                              ),
                              const CartItemUpdateDivider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: SText(
                                  '${cartItem.quantity}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const CartItemUpdateDivider(),
                              GestureDetector(
                                onTap: () => context
                                    .read<CartCubit>()
                                    .setCartItem(cartItem.product),
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 13, left: 5),
                                  child: CartItemUpdateButton(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ProductPriceText('\$${cartItem.totalPrice}',
              color: context.appTheme.primary)
        ],
      ),
    );
  }
}

class CartItemUpdateDivider extends StatelessWidget {
  const CartItemUpdateDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: VerticalDivider(
        indent: 0,
        endIndent: 0,
        color: context.appTheme.primary.withOpacity(.2),
      ),
    );
  }
}

class CartItemUpdateButton extends StatelessWidget {
  const CartItemUpdateButton(this.icon, {super.key, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: 15,
        ),
      ),
    );
  }
}

class CartScreenFooter extends StatelessWidget {
  const CartScreenFooter({super.key, required this.cartTotal});

  final double cartTotal;

  @override
  Widget build(BuildContext context) {
    const double minimumCartAmount = 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: .8,
            color: context.appTheme.primary.withOpacity(.2),
          ),
        ),
      ),
      child: Row(
        children: [
          //PRICE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SText(
                'Cart total',
                style: TextStyle(
                  fontFamily: AppFonts.inter,
                  fontSize: 12,
                  color: context.appTheme.primary.withOpacity(.6),
                ),
              ),
              SText(
                cartTotal > minimumCartAmount ? '\$$cartTotal' : '--',
                style: TextStyle(fontFamily: AppFonts.lora, fontSize: 16),
              ),
            ],
          ),
          Spacers.w25,
          // ACTION
          Expanded(
            child: AppPrimaryButton(
              child: const ButtonText('Checkout'),
              onPressed: () => context.pushNamed(AppRoutes.wishList.name),
            ),
          )
        ],
      ),
    );
  }
}

class CartScreenAppBar extends StatelessWidget {
  const CartScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderText('Cart'),
          LogOutButton(),
        ],
      ),
    );
  }
}
