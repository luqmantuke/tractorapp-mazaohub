import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FarmerHomeScreen extends StatelessWidget {
  const FarmerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Farmer Home', style: TextStyle(fontSize: 18.sp))),
      body: Center(
        child: Text('Welcome, Farmer!', style: TextStyle(fontSize: 18.sp)),
      ),
    );
  }
}
