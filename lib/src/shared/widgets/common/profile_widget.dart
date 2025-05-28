import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tractorapp/src/features/auth/presentation/providers/auth_provider.dart';
import '../../../core/constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonProfileWidget extends ConsumerWidget {
  const CommonProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 4.h),
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primaryGreen.withOpacity(0.2),
              child: const Icon(Icons.person,
                  size: 50, color: AppColors.primaryGreen),
            ),
            SizedBox(height: 2.h),
            Text('John Doe',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
            SizedBox(height: 1.h),
            Text('Farmer',
                style: TextStyle(color: Colors.grey[600], fontSize: 16.sp)),
            SizedBox(height: 3.h),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _profileDetailRow('Phone', '+255 123 456 789'),
                    _profileDetailRow('Location', 'Dodoma, Tanzania'),
                    _profileDetailRow('Joined', 'Jan 2024'),
                    _profileDetailRow('Account Type', 'Farmer'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                minimumSize: Size(double.infinity, 6.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: Text('Edit Profile',
                  style: TextStyle(color: AppColors.white, fontSize: 16.sp)),
            ),
            SizedBox(height: 2.h),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: Text('Sign Out', style: TextStyle(fontSize: 16.sp)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                minimumSize: Size(double.infinity, 6.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                ref.read(authProvider.notifier).signOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp)),
          Text(value,
              style: TextStyle(color: Colors.grey[700], fontSize: 15.sp)),
        ],
      ),
    );
  }
}
