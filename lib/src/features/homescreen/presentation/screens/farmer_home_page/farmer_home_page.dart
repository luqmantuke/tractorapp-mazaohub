import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tractorapp/src/core/constants/colors.dart';
import '../../widgets/farmer/farmer_app_bar.dart';
import '../../widgets/farmer/farmer_search_bar.dart';
import '../../widgets/farmer/farmer_map_widget.dart';
import '../../widgets/farmer/available_tractors_card.dart';

class FarmerHomePage extends StatelessWidget {
  final TextEditingController searchController;
  const FarmerHomePage({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map takes the whole screen
        const FarmerMapWidget(),

        // Top content (AppBar, SearchBar)
        Positioned(
          top: MediaQuery.of(context).padding.top, // below status bar
          left: 0,
          right: 0,
          child: Container(
            color: AppColors.white,
            child: Column(
              children: [
                const FarmerAppBar(location: 'Dar es Salaam'),
                const SizedBox(height: 12),
                FarmerSearchBar(controller: searchController),
              ],
            ),
          ),
        ),

        // Bottom card
        Positioned(
          left: 0,
          right: 0,
          bottom: 2.h, // adjust as needed for bottom nav
          child: AvailableTractorsCard(
            availableCount: 12,
            distance: '12 Hectors',
            estimatedTime: '12 Hrs',
            estimatedFuel: '120 Lts',
            estimatedCost: '300,000',
            onLease: () {},
          ),
        ),
      ],
    );
  }
}
