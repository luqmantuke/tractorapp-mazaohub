import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tractorapp/src/core/constants/colors.dart';
import 'package:tractorapp/src/shared/widgets/buttons/custombuttons.dart';

class FarmerMachineDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> machine;
  const FarmerMachineDetailsScreen({super.key, required this.machine});

  @override
  State<FarmerMachineDetailsScreen> createState() =>
      _FarmerMachineDetailsScreenState();
}

class _FarmerMachineDetailsScreenState
    extends State<FarmerMachineDetailsScreen> {
  int _quantity = 1;
  final double _unitPrice = 200000;

  @override
  Widget build(BuildContext context) {
    final machine = widget.machine;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageHeader(machine),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    _buildTitleRow(machine),
                    SizedBox(height: 1.h),
                    _buildLocationAndActive(machine),
                    SizedBox(height: 1.h),
                    _buildRating(),
                    SizedBox(height: 2.h),
                    Text('Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp)),
                    SizedBox(height: 1.h),
                    Text(
                      machine['description'] ??
                          'Culpa aliquam consequuntur veritatis at consequuntur praesentium beatae temporibus nobis. Velit dolorem facilis neque autem. Itaque voluptatem expedita qui eveniet id veritatis eaque. Blanditiis quia placeat nemo. Nobis laudantium nesciunt perspiciatis sit eligendi.',
                      style:
                          TextStyle(color: Colors.grey[700], fontSize: 15.sp),
                    ),
                    SizedBox(height: 2.h),
                    // _buildGallery(machine),
                    SizedBox(height: 2.h),
                    _buildQuantitySelector(),
                    SizedBox(height: 1.h),
                    _buildTotal(),
                    SizedBox(height: 2.h),
                    _buildActionButtons(context),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader(Map<String, dynamic> machine) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 32.h,
          child: FastCachedImage(
            url: machine['image'],
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 2.h,
          left: 3.w,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        Positioned(
          top: 3.h,
          right: 5.w,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('Active',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleRow(Map<String, dynamic> machine) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(machine['name'],
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp)),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                SizedBox(width: 1.w),
                Text(machine['location'],
                    style: TextStyle(color: Colors.grey[700], fontSize: 15.sp)),
              ],
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Tsh ',
                  style: TextStyle(color: Colors.grey[700], fontSize: 15.sp)),
              TextSpan(
                  text: '200,000',
                  style: TextStyle(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp)),
              TextSpan(
                  text: '/day',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14.sp)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationAndActive(Map<String, dynamic> machine) {
    return Text(
      'Last Active: 23, Mar 2025, 11:30PM',
      style: TextStyle(color: Colors.grey[500], fontSize: 13.sp),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 18),
        SizedBox(width: 1.w),
        Text('4.5',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp)),
        SizedBox(width: 1.w),
        Text(' (20 Review)',
            style: TextStyle(color: Colors.grey[600], fontSize: 14.sp)),
      ],
    );
  }

  // Widget _buildGallery(Map<String, dynamic> machine) {
  //   List<String> images = [
  //     machine['image'],
  //     machine['image'],
  //     machine['image'],
  //   ];
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: images
  //         .map((img) => Padding(
  //               padding: EdgeInsets.only(right: 2.w),
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(10),
  //                 child: Image.network(img,
  //                     width: 70, height: 70, fit: BoxFit.cover),
  //               ),
  //             ))
  //         .toList(),
  //   );
  // }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Quantity',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp)),
          Row(
            children: [
              _buildQuantityButton(Icons.remove, () {
                if (_quantity > 1) setState(() => _quantity--);
              }),
              SizedBox(width: 2.w),
              Text('$_quantity',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
              SizedBox(width: 2.w),
              _buildQuantityButton(Icons.add, () {
                setState(() => _quantity++);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.primaryGreen),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(4),
        child: Icon(icon, color: AppColors.primaryGreen, size: 22),
      ),
    );
  }

  Widget _buildTotal() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total (tsh):',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp)),
          Text('200,000',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            color: AppColors.primaryGreen,
            textColor: AppColors.white,
            text: 'Order Machine',
            onPressed: () {},
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            color: AppColors.white,
            textColor: AppColors.primaryGreen,
            isOutline: false,
            text: 'Back',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
