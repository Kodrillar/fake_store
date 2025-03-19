import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/widgets/app_primary_button.dart';
import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/core/widgets/button_text.dart';
import 'package:fake_store/src/core/widgets/header_text.dart';
import 'package:fake_store/src/core/widgets/product_name_text.dart';
import 'package:fake_store/src/core/widgets/product_price_text.dart';
import 'package:fake_store/src/features/home/presentation/screens/home.dart';
import 'package:fake_store/src/res/app_fonts.dart';
import 'package:fake_store/src/res/app_spacers.dart';
import 'package:fake_store/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screendapt/screendapt.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Column(
        children: [
          CartScreenAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: SContainer(
                child: Column(
                  children: [
                    CartProductCard(),
                    Spacers.h25,
                    CartProductCard(),
                    Spacers.h25,
                    CartProductCard(),
                    Spacers.h25,
                  ],
                ),
              ),
            ),
          ),
          CartScreenFooter()
        ],
      ),
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
  const CartProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: const DismissibleBackground(),
      key: const Key('1'), //TODO: Use product ID in Key
      onDismissed: (direction) {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //PRODUCT IMAGE
          Row(
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Spacers.w10,

              //PRODUCT DETAILS
              Column(
                children: [
                  const ProductNameText('"Awaken, My Love!"'),
                  Spacers.h10,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: context.appTheme.primary.withOpacity(.2),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 13, right: 5),
                          child: CartItemUpdateButton(Icons.remove),
                        ),
                        CartItemUpdateDivider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: SText(
                            '1',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        CartItemUpdateDivider(),
                        Padding(
                          padding: EdgeInsets.only(right: 13, left: 5),
                          child: CartItemUpdateButton(Icons.add),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          ProductPriceText('\$19.99', color: context.appTheme.primary)
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
  const CartScreenFooter({super.key});

  @override
  Widget build(BuildContext context) {
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
                '\$165.97',
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
