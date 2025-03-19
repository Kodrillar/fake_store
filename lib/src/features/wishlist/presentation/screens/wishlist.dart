import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/core/widgets/header_text.dart';
import 'package:fake_store/src/core/widgets/product_name_text.dart';
import 'package:fake_store/src/core/widgets/product_price_text.dart';
import 'package:fake_store/src/features/home/presentation/screens/home.dart';
import 'package:fake_store/src/res/app_spacers.dart';
import 'package:flutter/material.dart';
import 'package:screendapt/screendapt.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Column(
        children: [
          WishListScreenAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: SContainer(
                child: Column(
                  children: [
                    Spacers.h10,
                    WishListCard(),
                    Spacers.h10,
                    WishListCard(),
                    Spacers.h10,
                    WishListCard(),
                    Spacers.h10,
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WishListCard extends StatelessWidget {
  const WishListCard({super.key});

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
            Container(
              margin: const EdgeInsets.all(10),
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Spacers.w10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ProductNameText('"Dark Lane Demo Tapes"'),
                      //FAVORITE SELECTION
                      Icon(
                        Icons.favorite,
                        color: context.appTheme.favorite,
                        size: 18,
                      ),
                    ],
                  ),
                  Spacers.h5,
                  const ProductPriceText('\$19.99'),
                  Spacers.h10,
                  const WishlistButton(),
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
  const WishlistButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
