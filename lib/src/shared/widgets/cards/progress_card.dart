import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum SavingType {
  building,
  rent,
}

class ProgressCard extends StatelessWidget {
  final String title;
  final double progress;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final SavingType savingType;
  final String? targetAmount;
  final String? currentAmount;

  const ProgressCard({
    super.key,
    required this.title,
    required this.progress,
    required this.subtitle,
    required this.icon,
    this.onTap,
    this.savingType = SavingType.building,
    this.targetAmount,
    this.currentAmount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: savingType == SavingType.building
                          ? theme.colorScheme.primaryContainer
                          : theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      savingType == SavingType.building
                          ? Icons.home_outlined
                          : Icons.apartment_outlined,
                      color: savingType == SavingType.building
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                      size: 3.h,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        if (targetAmount != null && currentAmount != null) ...[
                          SizedBox(height: 0.5.h),
                          Text(
                            '$currentAmount / $targetAmount',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        savingType == SavingType.building
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary,
                      ),
                      minHeight: 0.4.h,
                    ),
                  ),
                  // Positioned(
                  //   right: 0,
                  //   top: -0.3.h,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 1.5.w,
                  //       vertical: 0.3.h,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: savingType == SavingType.building
                  //           ? theme.colorScheme.primaryContainer
                  //           : theme.colorScheme.secondaryContainer,
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: Text(
                  //       '${(progress * 100).toInt()}%',
                  //       style: theme.textTheme.labelSmall?.copyWith(
                  //         color: savingType == SavingType.building
                  //             ? theme.colorScheme.primary
                  //             : theme.colorScheme.secondary,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 8.sp,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 1.h),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
