import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/widgets/app_primary_button.dart';
import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/core/widgets/button_text.dart';
import 'package:fake_store/src/res/app_fonts.dart';
import 'package:fake_store/src/res/app_spacers.dart';
import 'package:fake_store/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screendapt/screendapt.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        color: context.appTheme.foreground,
        child: Column(
          children: [
            const ProductDetailsScreenAppBar(),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: SContainer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300,
                          child: Image.network(
                            'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                          ),
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
                      'Xbox One Elite Series 2 Controller',
                      maxLines: 1,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: context.appTheme.primary.withOpacity(.75)),
                    ),
                    Spacers.h10,
                    //CATEGORY
                    SText(
                      'Gaming Category',
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
                        const SText(
                          '4.25',
                          style: TextStyle(
                              fontSize: 10.5, fontWeight: FontWeight.w600),
                        ),
                        Spacers.w5,
                        SText(
                          '12 Reviews',
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
            const ProductDetailsFooter(),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsFooter extends StatelessWidget {
  const ProductDetailsFooter({super.key});

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
                '\$79.99',
                style: TextStyle(fontFamily: AppFonts.lora, fontSize: 16),
              ),
            ],
          ),
          Spacers.w25,
          // ACTION
          Expanded(
            child: AppPrimaryButton(
              child: const ButtonText('Add to cart'),
              onPressed: () => context.pushNamed(AppRoutes.cart.name),
            ),
          )
        ],
      ),
    );
  }
}

class ProductDetailsScreenAppBar extends StatelessWidget {
  const ProductDetailsScreenAppBar({super.key});

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
          const Icon(Icons.favorite_outline),
        ],
      ),
    );
  }
}
