import 'package:fake_store/src/core/widgets/app_scaffold.dart';
import 'package:fake_store/src/core/widgets/header_text.dart';
import 'package:fake_store/src/features/home/presentation/screens/home.dart';
import 'package:flutter/material.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Column(
        children: [
          WishListScreenAppBar(),
        ],
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
