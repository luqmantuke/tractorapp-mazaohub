import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MechanicalOwnerHomeScreen extends StatelessWidget {
  const MechanicalOwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text('Mechanical Owner Home', style: TextStyle(fontSize: 18.sp))),
      body: Center(
        child: Text('Welcome, Mechanical Owner!',
            style: TextStyle(fontSize: 18.sp)),
      ),
    );
  }
}
