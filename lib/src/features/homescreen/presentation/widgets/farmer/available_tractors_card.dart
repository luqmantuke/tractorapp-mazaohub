import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tractorapp/src/core/constants/colors.dart';
import 'package:tractorapp/src/shared/widgets/buttons/custombuttons.dart';

class AvailableTractorsCard extends StatelessWidget {
  final int availableCount;
  final String distance;
  final String estimatedTime;
  final String estimatedFuel;
  final String estimatedCost;
  final VoidCallback? onLease;

  const AvailableTractorsCard({
    super.key,
    required this.availableCount,
    required this.distance,
    required this.estimatedTime,
    required this.estimatedFuel,
    required this.estimatedCost,
    this.onLease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Available Tractors ($availableCount)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp)),
          SizedBox(height: 2.h),
          _buildRow('Distance', distance),
          _buildRow('Total estimated Time', estimatedTime),
          _buildRow('Estimated fuel', estimatedFuel),
          _buildRow('Estimated cost (Tzs)', estimatedCost),
          SizedBox(height: 2.h),
          CustomButton(
            text: 'Lease Tractor',
            onPressed: onLease ?? () {},
            color: AppColors.primaryGreen,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 15.sp, color: Colors.grey[700])),
          Text(value,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
