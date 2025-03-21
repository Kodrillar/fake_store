import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/core/widgets/app_snack_bar.dart';
import 'package:fake_store/src/core/widgets/header_text.dart';
import 'package:fake_store/src/core/widgets/log_out_button.dart';
import 'package:fake_store/src/core/widgets/product_image.dart';
import 'package:fake_store/src/core/widgets/product_name_text.dart';
import 'package:fake_store/src/core/widgets/product_price_text.dart';
import 'package:fake_store/src/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store/src/features/home/domain/product.dart';
import 'package:fake_store/src/features/wish_list/cubit/wish_list_cubit.dart';
import 'package:fake_store/src/features/wish_list/cubit/wish_list_state.dart';
import 'package:fake_store/src/res/app_spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screendapt/screendapt.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListCubit, WishListState>(
      builder: (context, state) {
        return AppScaffold(
          body: Column(
            children: [
              const WishListScreenAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: SContainer(
                    child: Column(
                      children: [
                        if (state.wishList.isEmpty)
                          SText(
                            'Your Wish list is currently empty!',
                            style:
                                TextStyle(color: context.appTheme.textAccent),
                          ),
                        for (Product product in state.wishList) ...[
                          WishListCard(product: product),
                          Spacers.h10,
                        ]
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class WishListCard extends StatelessWidget {
  const WishListCard({super.key, required this.product});
  final Product product;

  void _addToCart(BuildContext context) async {
    await context.read<CartCubit>().setCartItem(product);

    if (context.mounted) {
      AppSnackBar.show(context, message: 'Product added to Cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: context.appTheme.primary.withOpacity(.05),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(imageUrl: product.image),
            Spacers.w10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: ProductNameText(product.title)),
                      //FAVORITE SELECTION
                      GestureDetector(
                        onTap: () => context
                            .read<WishListCubit>()
                            .removeWishListItem(product),
                        child: Icon(
                          Icons.favorite,
                          color: context.appTheme.favorite,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  Spacers.h5,
                  ProductPriceText('\$${product.price}'),
                  Spacers.h10,
                  WishlistButton(onTap: () => _addToCart(context)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WishlistButton extends StatelessWidget {
  const WishlistButton({super.key, required this.onTap});

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: context.appTheme.background,
          borderRadius: BorderRadius.circular(8),
          child: const InkWell(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: SText(
                  'Add to cart',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WishListScreenAppBar extends StatelessWidget {
  const WishListScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderText('Wishlist'),
          LogOutButton(),
        ],
      ),
    );
  }
}
