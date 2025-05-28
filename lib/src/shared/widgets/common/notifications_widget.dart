import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/constants/colors.dart';

class CommonNotificationsWidget extends StatelessWidget {
  const CommonNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Booking Confirmed',
        'body': 'Your tractor booking is confirmed!',
        'date': 'Today'
      },
      {
        'title': 'Payment Received',
        'body': 'You have received a payment.',
        'date': 'Yesterday'
      },
      {
        'title': 'New Offer',
        'body': 'Check out new tractor offers near you.',
        'date': '2 days ago'
      },
    ];
    return ListView.separated(
      padding: EdgeInsets.all(5.w),
      itemCount: notifications.length,
      separatorBuilder: (_, __) => SizedBox(height: 2.h),
      itemBuilder: (context, index) {
        final notif = notifications[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryGreen.withOpacity(0.15),
              child: const Icon(Icons.notifications,
                  color: AppColors.primaryGreen),
            ),
            title: Text(notif['title']!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
            subtitle: Text(notif['body']!, style: TextStyle(fontSize: 15.sp)),
            trailing: Text(notif['date']!,
                style: TextStyle(color: Colors.grey[600], fontSize: 13.sp)),
          ),
        );
      },
    );
  }
}
