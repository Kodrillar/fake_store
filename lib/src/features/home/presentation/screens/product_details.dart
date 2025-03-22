import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/widgets/app_primary_button.dart';
import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/core/widgets/app_snack_bar.dart';
import 'package:fake_store/src/core/widgets/button_text.dart';
import 'package:fake_store/src/core/widgets/wish_list_update_icon.dart';
import 'package:fake_store/src/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store/src/features/home/domain/product.dart';

import 'package:fake_store/src/res/app_fonts.dart';
import 'package:fake_store/src/res/app_spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:screendapt/screendapt.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        color: context.appTheme.foreground,
        child: Column(
          children: [
            ProductDetailsScreenAppBar(product: product),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: SContainer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300,
                          child: Image.network(product.image),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: context.appTheme.background,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SText(
                      product.title,
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: context.appTheme.primary.withOpacity(.75)),
                    ),
                    Spacers.h10,
                    //CATEGORY
                    SText(
                      product.category,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: context.appTheme.textSecondary.withOpacity(.5),
                        fontSize: 12,
                      ),
                    ),

                    Spacers.h5,

                    //RATING
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 12,
                        ),
                        Spacers.w2,
                        SText(
                          '${product.rating.rate}',
                          style: const TextStyle(
                              fontSize: 10.5, fontWeight: FontWeight.w600),
                        ),
                        Spacers.w5,
                        SText(
                          '${product.rating.count} Reviews',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: context.appTheme.primary.withOpacity(.4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ProductDetailsFooter(product: product),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsFooter extends StatelessWidget {
  const ProductDetailsFooter({super.key, required this.product});

  final Product product;

  void _addToCart(BuildContext context) async {
    await context.read<CartCubit>().setCartItem(product);

    if (context.mounted) {
      AppSnackBar.show(context, message: 'Product added to Cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      color: context.appTheme.accent,
      child: Row(
        children: [
          //PRICE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SText(
                'Price',
                style: TextStyle(
                  fontFamily: AppFonts.inter,
                  fontSize: 12,
                ),
              ),
              SText(
                '\$${product.price}',
                style: TextStyle(fontFamily: AppFonts.lora, fontSize: 16),
              ),
            ],
          ),
          Spacers.w25,
          // ACTION
          Expanded(
            child: AppPrimaryButton(
              child: const ButtonText('Add to cart'),
              onPressed: () => _addToCart(context),
            ),
          )
        ],
      ),
    );
  }
}

class ProductDetailsScreenAppBar extends StatelessWidget {
  const ProductDetailsScreenAppBar({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Icon(
              Icons.arrow_back,
              color: context.appTheme.primary,
            ),
          ),
          WishListUpdateIcon(product: product)
        ],
      ),
    );
  }
}
