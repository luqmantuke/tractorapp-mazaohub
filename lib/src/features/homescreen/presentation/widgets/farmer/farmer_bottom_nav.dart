import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tractorapp/src/core/constants/colors.dart';

class FarmerBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const FarmerBottomNav(
      {super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      selectedItemColor: AppColors.orange,
      unselectedItemColor: AppColors.grey,
      selectedFontSize: 12.sp,
      unselectedFontSize: 12.sp,
      iconSize: 18.sp,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.house),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.tableCells),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.bell),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          label: '',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 8,
    );
  }
}
