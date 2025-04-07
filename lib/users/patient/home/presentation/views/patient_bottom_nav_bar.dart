import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

typedef NavItem = ({IconData icon, IconData activeIcon, String label});

class PatientBottomNavBar extends StatefulWidget {
  const PatientBottomNavBar({super.key});

  @override
  State<PatientBottomNavBar> createState() => _PatientBottomNavBarState();
}

class _PatientBottomNavBarState extends State<PatientBottomNavBar>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  late final List<AnimationController> _animationControllers;
  late final List<Animation<Offset>> _slideAnimations;

  static const _pageTransitionDuration = Duration(milliseconds: 300);

  final _pages = [
    const HomeView(),
    const ChatsPage(),
    const CommunityPage(),
    const ProfilePage(),
  ];

  /// list of records
  List<NavItem> _getNavItems(BuildContext context) => [
        (
          icon: IconlyLight.home,
          activeIcon: IconlyBold.home,
          label: S.of(context).home,
        ),
        (
          icon: IconlyLight.chat,
          activeIcon: IconlyBold.chat,
          label: S.of(context).chats,
        ),
        (
          icon: IconlyLight.user_1,
          activeIcon: IconlyBold.user_3,
          label: S.of(context).community,
        ),
        (
          icon: IconlyLight.profile,
          activeIcon: IconlyBold.profile,
          label: S.of(context).profile,
        ),
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
    final navItems = _getNavItems(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      body: PageView(
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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          unselectedLabelStyle: AppTextStyle.font15Bold(context),
          selectedLabelStyle: AppTextStyle.font15Bold(context),
          iconSize: context.setSp(40),
          onTap: _handlePageChange,
          items: navItems
              .map((item) => BottomNavigationBarItem(
                    icon: Icon(item.icon),
                    activeIcon: Icon(item.activeIcon),
                    label: item.label,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

// Pages content
class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('💬 ${S.of(context).chats}',
          style: const TextStyle(fontSize: 24)),
    );
  }
}

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('👥 ${S.of(context).community}',
          style: const TextStyle(fontSize: 24)),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('🙍 ${S.of(context).profile}',
          style: const TextStyle(fontSize: 24)),
    );
  }
}
