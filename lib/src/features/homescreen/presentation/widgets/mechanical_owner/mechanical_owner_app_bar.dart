import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/colors.dart';

class MechanicalOwnerAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const MechanicalOwnerAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(6.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Mechanical Owner Home', style: TextStyle(fontSize: 18.sp)),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // TODO: Navigate to notifications
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // TODO: Navigate to settings
          },
        ),
      ],
    );
  }
}
