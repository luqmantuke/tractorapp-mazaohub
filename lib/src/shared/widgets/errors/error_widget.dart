import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tractorapp/src/core/constants/colors.dart';
import 'package:tractorapp/src/shared/widgets/buttons/custombuttons.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final bool showRetry;

  const CustomErrorWidget({
    super.key,
    this.message = 'Something went wrong',
    required this.onRetry,
    this.showRetry = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // You can replace this with your own Lottie animation
              Lottie.asset(
                'assets/jsons/error_animation.json',
                height: 20.h,
                repeat: true,
              ),
              SizedBox(height: 2.h),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              if (showRetry) ...[
                SizedBox(height: 2.h),
                SizedBox(
                  width: 50.w,
                  child: CustomButton(
                    color: AppColors.primaryGreen,
                    text: 'Retry',
                    onPressed: onRetry,
                    textColor: AppColors.grey,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class InlineErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final bool showRetry;

  const InlineErrorWidget({
    super.key,
    this.message = 'Something went wrong',
    required this.onRetry,
    this.showRetry = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red[100]!,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: Colors.red[400],
            size: 24.sp,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.red[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (showRetry) ...[
                  SizedBox(height: 1.h),
                  GestureDetector(
                    onTap: onRetry,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.refresh_rounded,
                          size: 14.sp,
                          color: Colors.red[400],
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'Tap to retry',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.red[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final bool showRetry;

  const ShimmerErrorWidget({
    super.key,
    this.message = 'Something went wrong',
    required this.onRetry,
    this.showRetry = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 15.h,
            width: 15.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 8.h,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          if (showRetry) ...[
            SizedBox(height: 2.h),
            TextButton.icon(
              onPressed: onRetry,
              icon: Icon(
                Icons.refresh_rounded,
                size: 18.sp,
              ),
              label: Text(
                'Retry',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
