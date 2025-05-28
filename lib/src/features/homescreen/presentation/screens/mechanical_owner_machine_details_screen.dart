import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tractorapp/src/core/constants/colors.dart';
import 'package:go_router/go_router.dart';

class MechanicalOwnerMachineDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> machine;
  const MechanicalOwnerMachineDetailsScreen({super.key, required this.machine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageHeader(context, machine),
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
                    _buildTabBarSection(),
                    SizedBox(height: 2.h),
                    _buildTractorDetailsCard(),
                    SizedBox(height: 2.h),
                    _buildFuelConsumptionSection(),
                    SizedBox(height: 2.h),
                    _buildMaintenanceHistorySection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context, Map<String, dynamic> machine) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 32.h,
          child: Image.network(
            machine['image'],
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

  Widget _buildTabBarSection() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: AppColors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.orange,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            tabs: const [
              Tab(text: 'Activity'),
              Tab(text: 'Maintanance'),
              Tab(text: 'Revenue'),
            ],
          ),
          const SizedBox(
            height: 0,
            width: 0,
            child: TabBarView(
              children: [
                SizedBox.shrink(),
                SizedBox.shrink(),
                SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTractorDetailsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tractor Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(height: 1.h),
          Text(
            'To provide safe, efficient, and customer-focused transport services that help businesses thrive by ensuring goods reach their destination on time and in perfect condition.',
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              for (int i = 0; i < 3; i++)
                Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 1.h),
          _buildDetailsRow('Location:', 'Upanga street'),
          _buildDetailsRow('Coordinates:', '000087h897'),
          _buildDetailsRow('Duration:', '3 days'),
          _buildDetailsRow('Last Operator:', 'Ally Juma'),
          _buildDetailsRow('Contact:', '255 788 000 000'),
          _buildDetailsRow('Mechanic:', 'Juma Ally'),
          _buildDetailsRow('Cost:', 'Tsh. 120,000.00'),
          _buildDetailsRow('Issue:', 'No issue'),
          _buildDetailsRow('Active Hrs:', '200hrs'),
          _buildDetailsRow('InActive Hrs:', '12hrs'),
          _buildDetailsRow('Fuel History:', '11000lts'),
          _buildDetailsRow('Area Covered:', '12,000,000hct'),
          _buildDetailsRow('Last Maintenence:', '02.12.2023'),
          Row(
            children: [
              Text('Status:',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
              SizedBox(width: 2.w),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Available',
                    style: TextStyle(color: Colors.white, fontSize: 13.sp)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
              width: 120,
              child: Text(label,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14.sp))),
          Expanded(
              child: Text(value,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp))),
        ],
      ),
    );
  }

  Widget _buildFuelConsumptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fuel consumption',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Lts',
                      style:
                          TextStyle(color: Colors.grey[700], fontSize: 14.sp)),
                  Row(
                    children: [
                      Text('Last 7 days',
                          style: TextStyle(
                              color: Colors.grey[700], fontSize: 13.sp)),
                      Icon(Icons.keyboard_arrow_down, color: Colors.grey[700]),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              SizedBox(
                height: 80,
                child: Center(
                  child: Text('Fuel consumption chart here',
                      style: TextStyle(color: Colors.grey[400])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMaintenanceHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Maintenence History',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
            Text('See All',
                style: TextStyle(color: AppColors.orange, fontSize: 14.sp)),
          ],
        ),
        SizedBox(height: 1.h),
        _buildMaintenanceCard(),
      ],
    );
  }

  Widget _buildMaintenanceCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('Oil leakage',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('In-Active',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.sp)),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Text('22, Mar 2025, 3 hrs ago',
                        style: TextStyle(
                            color: Colors.grey[600], fontSize: 13.sp)),
                    Text('Cost: Tzs. 100,000.00',
                        style: TextStyle(
                            color: Colors.grey[600], fontSize: 13.sp)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            'To provide safe, efficient, and customer-focused transport services that help businesses thrive by ensuring goods reach their destination on time and in perfect condition.',
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          SizedBox(height: 1.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                minimumSize: Size(double.infinity, 5.h),
              ),
              onPressed: () {},
              child: Text('Assign Driver',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
            ),
          ),
        ],
      ),
    );
  }
}
