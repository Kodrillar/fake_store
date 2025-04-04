import 'dart:async';

import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/utils/async_state.dart';
import 'package:fake_store/src/core/widgets/app_loader.dart';
import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/core/widgets/app_snack_bar.dart';
import 'package:fake_store/src/core/widgets/header_text.dart';
import 'package:fake_store/src/core/widgets/log_out_button.dart';
import 'package:fake_store/src/core/widgets/product_image.dart';
import 'package:fake_store/src/core/widgets/product_name_text.dart';
import 'package:fake_store/src/core/widgets/product_price_text.dart';
import 'package:fake_store/src/core/widgets/wish_list_update_icon.dart';
import 'package:fake_store/src/features/home/domain/product.dart';
import 'package:fake_store/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:fake_store/src/features/home/presentation/cubit/home_state.dart';
import 'package:fake_store/src/features/wish_list/presentation/cubit/wish_list_cubit.dart';
import 'package:fake_store/src/res/app_spacers.dart';
import 'package:fake_store/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:screendapt/screendapt.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _fetchProducts() async {
    if (!context.read<HomeCubit>().state.asyncState.hasData) {
      context.read<HomeCubit>().fetchProducts();
    }
  }

  Future<void> _fetchWishlist() async =>
      context.read<WishListCubit>().fetchWishListItems();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchProducts();
      _fetchWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          const HomeScreenAppBar(),
          Expanded(
            child: RefreshIndicator(
              color: context.appTheme.accent,
              backgroundColor: context.appTheme.primary,
              onRefresh: () => context.read<HomeCubit>().fetchProducts(),
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
                      BlocConsumer<HomeCubit, HomeState>(
                        listenWhen: (previous, current) =>
                            current is AsyncError && previous is! AsyncError,
                        listener: (context, state) {
                          if (state.asyncState is AsyncError) {
                            AppSnackBar.show(context,
                                message: (state.asyncState as AsyncError)
                                    .error
                                    .toString());
                          }
                        },
                        builder: (context, homeState) {
                          return switch (homeState.asyncState) {
                            AsyncLoading() => const AppLoader(),
                            AsyncError() => SText(
                                (homeState.asyncState as AsyncError)
                                    .error
                                    .toString()),
                            AsyncData() => Column(
                                children: [
                                  if (homeState.asyncState is AsyncData)
                                    for (Product product
                                        in (homeState.asyncState as AsyncData)
                                            .data) ...[
                                      GestureDetector(
                                        onTap: () => context.pushNamed(
                                          AppRoutes.productDetails.name,
                                          extra: product,
                                        ),
                                        child: ProductCard(product: product),
                                      ),
                                      Spacers.h10
                                    ],
                                ],
                              )
                          };
                        },
                      ),
                    ],
                  ),
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
  const ProductCard({super.key, required this.product});

  final Product product;

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
            ProductImage(imageUrl: product.image),

            Spacers.w20,

            //DETAILS
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: ProductCardDetails(product: product)),

                  //FAVORITE SELECTION
                  WishListUpdateIcon(product: product)
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
  const ProductCardDetails({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductNameText(product.title),
        SText(
          product.category,
          maxLines: 1,
          style: TextStyle(
            fontSize: 11,
            color: context.appTheme.textSecondary,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Spacers.h10,

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
              style:
                  const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Spacers.h10,

        //PRICE
        ProductPriceText('\$${product.price}')
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
          HeaderText('Welcome,\nKind User'),
          LogOutButton(),
        ],
      ),
    );
  }
}
