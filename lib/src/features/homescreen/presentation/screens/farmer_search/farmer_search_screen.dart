import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tractorapp/src/core/constants/colors.dart';
import '../farmer_machine_details/farmer_machine_details_screen.dart';

class FarmerSearchScreen extends StatefulWidget {
  const FarmerSearchScreen({super.key});

  @override
  State<FarmerSearchScreen> createState() => _FarmerSearchScreenState();
}

class _FarmerSearchScreenState extends State<FarmerSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedBrand = 'All';
  List<String> brands = ['All', 'John Deer', 'Massey', 'New Holland'];

  final List<Map<String, String>> _dummyTractors = [
    {
      'image':
          'https://images.unsplash.com/photo-1606739211185-2c846d734a6d?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'HTDEMO1',
      'brand': 'John Deer',
      'status': 'Active',
      'location': 'Upanga street',
      'lastActive': '23, Mar 2025, 11:30PM',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1602446692855-6d096499f69b?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'HTDEMO1',
      'brand': 'Massey',
      'status': 'Active',
      'location': 'Upanga street',
      'lastActive': '23, Mar 2025, 11:30PM',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1508042084044-8e6975d7272c?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'HTDEMO1',
      'brand': 'New Holland',
      'status': 'Active',
      'location': 'Upanga street',
      'lastActive': '23, Mar 2025, 11:30PM',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1606739211185-2c846d734a6d?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'HTDEMO1',
      'brand': 'John Deer',
      'status': 'Active',
      'location': 'Upanga street',
      'lastActive': '23, Mar 2025, 11:30PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredTractors =
        _dummyTractors.where((tractor) {
      final matchesBrand =
          _selectedBrand == 'All' || tractor['brand'] == _selectedBrand;
      final matchesSearch = _searchController.text.isEmpty ||
          tractor['name']!
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      return matchesBrand && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Center(
                child: Text(
                  'Tractors & Machinery',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              _buildSearchBar(),
              SizedBox(height: 2.h),
              _buildBrandChips(),
              SizedBox(height: 2.h),
              Expanded(
                child: ListView.separated(
                  itemCount: filteredTractors.length,
                  separatorBuilder: (_, __) => SizedBox(height: 4.h),
                  itemBuilder: (context, index) {
                    final tractor = filteredTractors[index];
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed('farmer-machine-details',
                            extra: tractor);
                      },
                      child: _TractorCard(tractor: tractor),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'Search here',
        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
        filled: true,
        fillColor: AppColors.grey.withOpacity(0.12),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 3.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildBrandChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: brands.map((brand) {
          final isSelected = _selectedBrand == brand;
          return Padding(
            padding: EdgeInsets.only(right: 1.w),
            child: ChoiceChip(
              label: Text(brand, style: TextStyle(fontSize: 14.sp)),
              selected: isSelected,
              onSelected: (_) => setState(() => _selectedBrand = brand),
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
}

class _TractorCard extends StatelessWidget {
  final Map<String, String> tractor;
  const _TractorCard({required this.tractor});

  @override
  Widget build(BuildContext context) {
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
              borderRadius: BorderRadius.circular(12),
              child: FastCachedImage(
                url: tractor['image']!,
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
                  Text(
                    tractor['name']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.sp,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      const _StatusChip(
                          label: 'MazaoHub', color: AppColors.primaryGreen),
                      SizedBox(width: 2.w),
                      _StatusChip(
                          label: tractor['status']!, color: Colors.orange),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 16, color: Colors.grey[600]),
                      SizedBox(width: 1.w),
                      Text(
                        tractor['location']!,
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 15.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'Last Active: ${tractor['lastActive']}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
