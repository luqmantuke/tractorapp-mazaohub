import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tractorapp/src/core/providers/shared_preferences/shared_preference_provider.dart';

class FarmerAppBar extends ConsumerWidget {
  final String location;
  final VoidCallback? onNotificationTap;

  const FarmerAppBar({
    super.key,
    required this.location,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 2.h,
            child: Text(
              ref.watch(userNamePreferenceProvider).substring(0, 1),
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nearby,',
                    style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.locationDot,
                        size: 15.sp, color: Colors.black),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: Row(
                        spacing: 1.w,
                        children: [
                          Text(
                            location,
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.bell,
                size: 18.sp, color: Colors.grey[700]),
            onPressed: onNotificationTap,
          ),
        ],
      ),
    );
  }
}
