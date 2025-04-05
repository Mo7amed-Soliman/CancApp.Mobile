import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/home_view_body.dart';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  late final List<AnimationController> _animationControllers;
  late final List<Animation<Offset>> _slideAnimations;
  int _currentIndex = 0;

  static const _pageTransitionDuration = Duration(milliseconds: 300);
  static const _pages = [
    HomeViewBody(),
    ChatsPage(),
    CommunityPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(
      _pages.length,
      (index) => AnimationController(
        vsync: this,
        duration: _pageTransitionDuration,
      ),
    );

    _slideAnimations = List.generate(
      _pages.length,
      (index) => Tween<Offset>(
        begin: Offset.zero,
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationControllers[index],
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationControllers.first.forward();
  }

  @override
  void dispose() {
    for (final controller in _animationControllers) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChange(int newIndex) {
    if (newIndex == _currentIndex) return;

    final direction = newIndex > _currentIndex ? 1.0 : -1.0;

    _setupPageAnimation(newIndex, Offset(direction, 0.0), Offset.zero);

    _executePageTransition(newIndex);
  }

  void _setupPageAnimation(int index, Offset begin, Offset end) {
    _slideAnimations[index] = Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _animationControllers[index],
        curve: Curves.easeInOut,
      ),
    );
  }

  void _executePageTransition(int newIndex) {
    _animationControllers[_currentIndex].reset();
    _animationControllers[newIndex].reset();
    _animationControllers[_currentIndex].forward();
    _animationControllers[newIndex].forward();

    _pageController.jumpToPage(newIndex);
    setState(() => _currentIndex = newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) => setState(() => _currentIndex = index),
          children: [
            for (int i = 0; i < _pages.length; i++)
              SlideTransition(
                position: _slideAnimations[i],
                child: _pages[i],
              ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Theme _buildBottomNavBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedLabelStyle: bulidTextStyle(),
        selectedLabelStyle: bulidTextStyle(),
        iconSize: context.setSp(40),
        onTap: _handlePageChange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.home),
            activeIcon: Icon(IconlyBold.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.chat),
            activeIcon: Icon(IconlyBold.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.user_1),
            activeIcon: Icon(IconlyBold.user_3),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.profile),
            activeIcon: Icon(IconlyBold.profile),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  TextStyle bulidTextStyle() {
    return TextStyle(
      fontSize: context.setSp(16),
      fontWeight: FontWeight.w700,
    );
  }
}

// Pages content
class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('💬 Chats', style: TextStyle(fontSize: 24)),
    );
  }
}

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('👥 Community', style: TextStyle(fontSize: 24)),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('🙍 Profile', style: TextStyle(fontSize: 24)),
    );
  }
}
