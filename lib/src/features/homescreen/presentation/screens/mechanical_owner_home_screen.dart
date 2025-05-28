import 'package:flutter/material.dart';
import '../widgets/mechanical_owner/mechanical_owner_app_bar.dart';
import '../widgets/mechanical_owner/mechanical_owner_bottom_nav.dart';
import 'package:tractorapp/src/shared/widgets/common/notifications_widget.dart';
import 'package:tractorapp/src/shared/widgets/common/profile_widget.dart';
import '../widgets/mechanical_owner/mechanical_owner_home_page.dart';

class MechanicalOwnerHomeScreen extends StatefulWidget {
  const MechanicalOwnerHomeScreen({super.key});

  @override
  State<MechanicalOwnerHomeScreen> createState() =>
      _MechanicalOwnerHomeScreenState();
}

class _MechanicalOwnerHomeScreenState extends State<MechanicalOwnerHomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    const MechanicalOwnerHomePage(),
    const CommonNotificationsWidget(),
    const CommonProfileWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MechanicalOwnerAppBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MechanicalOwnerBottomNav(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
