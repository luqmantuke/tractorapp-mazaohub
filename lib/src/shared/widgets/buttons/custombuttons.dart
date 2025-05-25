import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;
  final bool isOutline;

  const CustomButton({
    required this.text,
    this.onPressed,
    required this.color,
    required this.textColor,
    this.isOutline = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 6.5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutline ? Colors.white : color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // More rounded edges
            side: isOutline
                ? BorderSide(color: color, width: 1.5)
                : BorderSide.none,
          ),
          elevation: 0,
          foregroundColor: isOutline ? color : textColor, // ripple effect color
        ),
        onPressed: onPressed ??
            (isOutline ? () => Navigator.of(context).maybePop() : null),
        child: Text(
          text,
          style: TextStyle(
            color: isOutline ? color : textColor,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
