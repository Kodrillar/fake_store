import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/features/home/presentation/screens/home.dart';
import 'package:fake_store/src/res/app_svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavHomeView extends StatelessWidget {
  const NavHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeScreen(),
      bottomNavigationBar: HomeBottomNavBar(
        onTap: (currentIndex) {},
        children: [
          SvgPicture.asset(AppSvgs.home),
          Icon(
            Icons.favorite_outline,
            color: context.appTheme.textAccent,
          ),
          SvgPicture.asset(
            AppSvgs.cart,
            colorFilter: ColorFilter.mode(
              context.appTheme.textAccent,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar(
      {super.key, required this.children, required this.onTap});

  final List<Widget> children;
  final void Function(int currentIndex) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.appTheme.primary.withOpacity(.035),
            width: 1.8,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var index = 0; index < children.length; index++)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: children[index],
                ),
              )
          ],
        ),
      ),
    );
  }
}
