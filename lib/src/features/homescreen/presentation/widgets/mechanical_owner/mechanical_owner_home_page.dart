import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/colors.dart';

class MechanicalOwnerHomePage extends StatefulWidget {
  const MechanicalOwnerHomePage({super.key});

  @override
  State<MechanicalOwnerHomePage> createState() =>
      _MechanicalOwnerHomePageState();
}

class _MechanicalOwnerHomePageState extends State<MechanicalOwnerHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _tractorData = [
    {
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
      'title': 'Massey Ferguson 240',
      'location': 'Manyara, Tz',
      'coordinates': '-1872696, -7867890',
      'time': '8 hrs ago',
      'desc':
          'To provide safe, efficient, and customer-focused transport services that help businesses thrive by ensuring goods reach their destination on time and in perfect condition.',
      'active': true,
    },
    {
      'image':
          'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
      'title': 'John Deere 5050D',
      'location': 'Arusha, Tz',
      'coordinates': '-1872697, -7867891',
      'time': '5 hrs ago',
      'desc':
          'Reliable and powerful tractor for all your farming needs. Ensures timely delivery and efficiency.',
      'active': true,
    },
    {
      'image':
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=400&q=80',
      'title': 'New Holland 3630',
      'location': 'Dodoma, Tz',
      'coordinates': '-1872698, -7867892',
      'time': '2 hrs ago',
      'desc':
          'Perfect for large scale farming and heavy-duty tasks. Available for lease now.',
      'active': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage:
                    AssetImage('assets/images/avatar.png'), // Placeholder
              ),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nearby,',
                      style:
                          TextStyle(fontSize: 15.sp, color: Colors.grey[700])),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: AppColors.primaryGreen, size: 18.sp),
                      SizedBox(width: 1.w),
                      Text('Dar es Salaam',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp)),
                      Icon(Icons.keyboard_arrow_down,
                          color: Colors.black, size: 18.sp),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.notifications_none,
                    color: Colors.grey[600], size: 24.sp),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search here',
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.orange,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'In-Active'),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTractorList(active: true),
              _buildTractorList(active: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTractorList({required bool active}) {
    final filtered = _tractorData.where((t) => t['active'] == active).toList();
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final data = filtered[index];
        return _buildTractorCard(data: data);
      },
    );
  }

  Widget _buildTractorCard({required Map<String, dynamic> data}) {
    final active = data['active'] as bool;
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'mechanical-owner-machine-details',
          extra: {
            'image': data['image'] ?? 'https://via.placeholder.com/150',
            'name': data['title'] ?? 'Unknown',
            'location': data['location'] ?? 'Unknown',
            // ...add all other fields with defaults
          },
        );
      },
      child: Container(
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
                    data['image'],
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
                            child: Text(data['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp)),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color:
                                  active ? AppColors.primaryGreen : Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              active ? 'Active' : 'In-Active',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      Text(data['location'],
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 14.sp)),
                      Text('Coordinates: ${data['coordinates']}',
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 13.sp)),
                      Text(data['time'],
                          style: TextStyle(
                              color: Colors.grey[500], fontSize: 12.sp)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            Text(
              data['desc'],
              style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
            ),
            SizedBox(height: 1.5.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryGreen),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: Size(double.infinity, 5.h),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    child: Text('Cancel',
                        style: TextStyle(
                            color: AppColors.primaryGreen, fontSize: 14.sp)),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: Size(double.infinity, 5.h),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    child: Text('Lease Tractor',
                        style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
