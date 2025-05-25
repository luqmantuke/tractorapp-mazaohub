import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:tractorapp/src/shared/widgets/buttons/custombuttons.dart';
import '../../data/models/onboarding_page.dart';
import '../widgets/onboarding_image.dart';

final List<OnboardingPage> onboardingPages = [
  OnboardingPage(
    title: 'Unlocking Knowledge',
    description:
        'Knowledge at your fingertips: E-Learning for Rural Water Professionals',
    imageUrl:
        'https://images.unsplash.com/photo-1606739211185-2c846d734a6d?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  OnboardingPage(
    title: 'A Fresh Start',
    description: 'A fresh start for your business: Start your journey with us',
    imageUrl:
        'https://images.unsplash.com/photo-1602446692855-6d096499f69b?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  OnboardingPage(
    title: 'Mechanic Everywhere',
    description:
        'Find a mechanic near you: Get your vehicle fixed quickly and easily',
    imageUrl:
        'https://images.unsplash.com/photo-1508042084044-8e6975d7272c?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  // Add more pages as needed
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      context.goNamed('login');
    }
  }

  void _skip() {
    context.goNamed('login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingPages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final page = onboardingPages[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  OnboardingImage(imageUrl: page.imageUrl),
                  Container(
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          page.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          page.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white, fontSize: 16.sp),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onboardingPages.length,
                            (dotIndex) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 1.w),
                              width: 6.w,
                              height: 0.7.h,
                              decoration: BoxDecoration(
                                color: _currentPage == dotIndex
                                    ? Colors.orange
                                    : Colors.white54,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        CustomButton(
                          text: _currentPage == onboardingPages.length - 1
                              ? 'Get Started'
                              : 'Next',
                          onPressed: _nextPage,
                          color: Colors.orange,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 2.h),
                        TextButton(
                          onPressed: _skip,
                          child: Text('Skip',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: 6.h,
            left: 6.w,
            child: Text(
              '9:09',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
