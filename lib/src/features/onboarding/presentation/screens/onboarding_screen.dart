import 'package:flutter/material.dart';
import '../../data/models/onboarding_page.dart';
import '../widgets/onboarding_image.dart';

final List<OnboardingPage> onboardingPages = [
  OnboardingPage(
    title: 'Unlocking Knowledge',
    description:
        'Knowledge at your fingertips: E-Learning for Rural Water Professionals',
    imageUrl:
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
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
      // TODO: Navigate to login or home
    }
  }

  void _skip() {
    // TODO: Navigate to login or home
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 48.0),
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
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onboardingPages.length,
                            (dotIndex) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 24,
                              height: 4,
                              decoration: BoxDecoration(
                                color: _currentPage == dotIndex
                                    ? Colors.orange
                                    : Colors.white54,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          onPressed: _nextPage,
                          child: Text(_currentPage == onboardingPages.length - 1
                              ? 'Get Started'
                              : 'Next'),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: _skip,
                          child: const Text('Skip',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const Positioned(
            top: 48,
            left: 24,
            child: Text(
              '9:09',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
