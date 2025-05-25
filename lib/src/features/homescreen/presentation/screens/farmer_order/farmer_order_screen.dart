import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:tractorapp/src/core/constants/colors.dart';
import 'package:tractorapp/src/shared/widgets/buttons/custombuttons.dart';

class FarmerOrderScreen extends StatefulWidget {
  final Map<String, dynamic> machine;
  const FarmerOrderScreen({super.key, required this.machine});

  @override
  State<FarmerOrderScreen> createState() => _FarmerOrderScreenState();
}

class _FarmerOrderScreenState extends State<FarmerOrderScreen> {
  int _selectedHour = 3;
  int _selectedDay = 20;
  final List<int> _hours = [1, 2, 3, 5, 6, 7];
  final List<String> _weekdays = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT'
  ];
  final List<int> _days = [18, 19, 20, 21, 22, 23, 24];

  @override
  Widget build(BuildContext context) {
    final machine = widget.machine;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                _buildAppBar(context),
                SizedBox(height: 2.h),
                Text('May, 2025',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.sp)),
                SizedBox(height: 3.h),
                _buildHourChips(),
                SizedBox(height: 3.h),
                _buildCalendar(),
                SizedBox(height: 3.h),
                _buildTractorCard(machine),
                SizedBox(height: 2.h),
                _buildTractorDetails(),
                SizedBox(height: 2.h),
                _buildPaymentButtons(),
                SizedBox(height: 2.h),
              ],
            ),
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

  Widget _buildHourChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _hours.map((hr) {
          final isSelected = _selectedHour == hr;
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: ChoiceChip(
              label: Text('${hr}hr', style: TextStyle(fontSize: 15.sp)),
              selected: isSelected,
              onSelected: (_) => setState(() => _selectedHour = hr),
              selectedColor: AppColors.orange,
              backgroundColor: AppColors.white,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.white : AppColors.orange,
                fontWeight: FontWeight.w500,
              ),
              shape: const StadiumBorder(
                side: BorderSide(color: AppColors.orange),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_days.length, (i) {
        final day = _days[i];
        final weekday = _weekdays[i];
        final isSelected = _selectedDay == day;
        return GestureDetector(
          onTap: () => setState(() => _selectedDay = day),
          child: Column(
            children: [
              Text(weekday,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.sp)),
              SizedBox(height: 0.5.h),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.grey.withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text('$day',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15.sp)),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTractorCard(Map<String, dynamic> machine) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FastCachedImage(
                url: machine['image'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(machine['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 17.sp)),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      const _StatusChip(
                          label: 'MazaoHub', color: AppColors.primaryGreen),
                      SizedBox(width: 2.w),
                      const _StatusChip(
                          label: 'Active', color: AppColors.orange),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 16, color: Colors.grey[600]),
                      SizedBox(width: 1.w),
                      Text(machine['location'],
                          style: TextStyle(
                              color: Colors.grey[700], fontSize: 15.sp)),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text('Last Active: 23, Mar 2025, 11:30PM',
                      style:
                          TextStyle(color: Colors.grey[500], fontSize: 13.sp)),
                ],
              ),
            ),
          ),
        ],
      ),
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
          SizedBox(height: 1.h),
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
          text: 'Pay Now',
          color: AppColors.primaryGreen,
          textColor: AppColors.white,
          onPressed: () {},
        ),
        SizedBox(height: 1.h),
        CustomButton(
          text: 'Pay Later',
          color: AppColors.primaryGreen,
          textColor: AppColors.primaryGreen,
          isOutline: true,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
