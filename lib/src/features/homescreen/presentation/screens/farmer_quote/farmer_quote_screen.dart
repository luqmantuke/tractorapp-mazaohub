import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tractorapp/src/core/constants/colors.dart';
import 'package:tractorapp/src/shared/widgets/buttons/custombuttons.dart';

class FarmerQuoteScreen extends StatelessWidget {
  const FarmerQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              _buildAppBar(context),
              SizedBox(height: 3.h),
              _buildTractorDetails(),
              SizedBox(height: 4.h),
              _buildPaymentButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        SizedBox(width: 2.w),
        Text('Tractor for Rent',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
      ],
    );
  }

  Widget _buildTractorDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tractor Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
          SizedBox(height: 1.5.h),
          _buildDetailRow('Time:', '1day'),
          _buildDetailRow('Total payments:', 'Tsh 200,000.00'),
          _buildDetailRow('VAT 18%:', 'Tsh 200,000.00'),
          _buildDetailRow('TOTAL:', 'Tsh 200,000.00', isTotal: true),
          Divider(height: 3.h),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15.sp)),
          Text(value,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15.sp)),
        ],
      ),
    );
  }

  Widget _buildPaymentButtons() {
    return Column(
      children: [
        CustomButton(
          text: 'Pay by Lipa Namba',
          color: AppColors.primaryGreen,
          textColor: AppColors.white,
          onPressed: () {},
        ),
        SizedBox(height: 2.h),
        CustomButton(
          text: 'Pay by Bank',
          color: AppColors.primaryGreen,
          textColor: AppColors.primaryGreen,
          isOutline: true,
          onPressed: () {},
        ),
      ],
    );
  }
}
