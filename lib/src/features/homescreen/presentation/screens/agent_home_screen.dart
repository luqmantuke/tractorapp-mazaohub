import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgentHomeScreen extends StatelessWidget {
  const AgentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Agent Home', style: TextStyle(fontSize: 18.sp))),
      body: Center(
        child: Text('Welcome, Agent!', style: TextStyle(fontSize: 18.sp)),
      ),
    );
  }
}
