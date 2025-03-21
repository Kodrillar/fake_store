import 'package:fake_store/src/core/extensions/build_context.dart';
import 'package:fake_store/src/features/cart/presentation/screens/cart.dart';
import 'package:fake_store/src/features/home/domain/navigation_bar_detail.dart';
import 'package:fake_store/src/features/home/presentation/cubit/home_state.dart';
import 'package:fake_store/src/features/home/presentation/screens/home.dart';
import 'package:fake_store/src/features/wish_list/presentation/screens/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavHomeView extends StatelessWidget {
  const NavHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: navIndexNotifier,
      builder: (context, currentIndex, _) {
        return Scaffold(
          body: [
            const HomeScreen(),
            const WishListScreen(),
            const CartScreen(),
          ][currentIndex],
          bottomNavigationBar: HomeBottomNavBar(
              onTap: (currentIndex) => navIndexNotifier.value = currentIndex,
              children: List<Widget>.generate(
                NavigationBarDetail.navIcons.length,
                (index) => NavBarIcon(
                  icon: NavigationBarDetail.navIcons[index],
                  isSelected: index == currentIndex,
                ),
              )),
        );
      },
    );
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({super.key, required this.icon, this.isSelected = false});
  final String icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      colorFilter: ColorFilter.mode(
        isSelected ? context.appTheme.primary : context.appTheme.textAccent,
        BlendMode.srcIn,
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
