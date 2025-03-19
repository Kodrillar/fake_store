import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/core/widgets/header_text.dart';
import 'package:fake_store/src/res/app_fonts.dart';
import 'package:fake_store/src/res/app_spacers.dart';
import 'package:fake_store/src/res/app_svgs.dart';
import 'package:fake_store/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:screendapt/screendapt.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          const HomeScreenAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: SContainer(
                child: Column(
                  children: [
                    Spacers.h20,
                    const Align(
                      alignment: Alignment.topLeft,
                      child: HeaderText(
                        'Fake Store',
                        fontSize: 24,
                      ),
                    ),
                    Spacers.h25,
                    GestureDetector(
                      onTap: () =>
                          context.pushNamed(AppRoutes.productDetails.name),
                      child: const ProductCard(),
                    ),
                    Spacers.h10,
                    const ProductCard(),
                    Spacers.h10,
                    const ProductCard(),
                    Spacers.h10,
                    const ProductCard(),
                    Spacers.h10,
                    const ProductCard(),
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

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: context.appTheme.primary.withOpacity(.05),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //IMAGE
            Container(
              margin: const EdgeInsets.all(10),
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(5),
              ),
            ),

            Spacers.w20,

            //DETAILS
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: ProductCardDetails()),

                  //FAVORITE SELECTION
                  Icon(
                    Icons.favorite_outline,
                    // color: context.appTheme.favorite,
                    color: context.appTheme.secondary.withOpacity(.25),
                    size: 18,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductCardDetails extends StatelessWidget {
  const ProductCardDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SText(
          '"Awaken, My Love!"',
          maxLines: 1,
          style: TextStyle(
              fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
        ),
        SText(
          'Childish Gambino',
          maxLines: 1,
          style: TextStyle(
            fontSize: 11,
            color: context.appTheme.textSecondary,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Spacers.h10,

        //RATING
        const Row(
          children: [
            Icon(
              Icons.star,
              size: 12,
            ),
            Spacers.w2,
            SText(
              '4.25',
              style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Spacers.h10,
        //RATING
        const SText(
          '\$19.99',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderText('Welcome,\nUsername'),
          LogOutButton(),
        ],
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.appTheme.accent,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(AppSvgs.logOut),
        ),
        SText(
          'Log out',
          style: TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.lato,
          ),
        )
      ],
    );
  }
}
