import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/core/widgets/app_snack_bar.dart';
import 'package:fake_store/src/features/home/domain/product.dart';
import 'package:fake_store/src/features/wish_list/presentation/cubit/wish_list_cubit.dart';
import 'package:fake_store/src/features/wish_list/presentation/cubit/wish_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListUpdateIcon extends StatelessWidget {
  const WishListUpdateIcon({super.key, required this.product});

  final Product product;

  void _updateWishList(BuildContext context) async {
    final bool addedProduct =
        await context.read<WishListCubit>().updateWishList(product);

    if (context.mounted) {
      AppSnackBar.show(
        context,
        message: addedProduct
            ? 'Product added to Wish list'
            : 'Product removed from Wish list',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListCubit, WishListState>(
      builder: (context, state) {
        final productIsInWishList =
            context.watch<WishListCubit>().checkIfProductIsInWishList(product);

        return GestureDetector(
          onTap: () => _updateWishList(context),
          child: Icon(
            productIsInWishList ? Icons.favorite : Icons.favorite_outline,
            color: productIsInWishList
                ? context.appTheme.favorite
                : context.appTheme.secondary.withOpacity(.25),
            size: 18,
          ),
        );
      },
    );
  }
}
