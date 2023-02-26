import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mallika/gen/assets.gen.dart';
import 'package:mallika/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page?.floor() ?? 0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _navigateToLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(prefFirstLaunch, false);
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: defaultOnboardingModel.length,
            itemBuilder: (context, index) {
              return CustomScrollView(slivers: [
                SliverAppBar(
                  flexibleSpace: Image(
                    image: AssetImage(defaultOnboardingModel[index].imagePath),
                    fit: BoxFit.cover,
                    height: 500,
                  ),
                  expandedHeight: 300,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarBrightness: Brightness.dark,
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size(
                      double.infinity,
                      30,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 24),
                    Assets.images.icChef.image(
                      width: 70,
                      height: 70,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      defaultOnboardingModel[index].title.toUpperCase(),
                      style: GoogleFonts.abel(
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        defaultOnboardingModel[index].description,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 16,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
                ),
              ]);
            },
          ),
          Positioned(
            top: 48,
            right: 14,
            child: ElevatedButton(
              onPressed: () {
                _navigateToLogin();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              child: Text(
                _currentIndex != 2 ? 'Skip' : 'Next',
                style: GoogleFonts.aBeeZee(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 48,
            right: 0,
            left: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [0, 1, 2].map((e) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: e == _currentIndex
                        ? const Color(0xFFFF8527)
                        : Colors.white,
                    border: Border.all(
                      color: const Color(0xFFFF8527),
                      width: 1,
                    ),
                    shape: BoxShape.circle,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
