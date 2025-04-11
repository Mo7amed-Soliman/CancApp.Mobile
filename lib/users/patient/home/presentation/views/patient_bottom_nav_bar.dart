import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/chat/presentation/views/chats_list_view%20dart';
import 'package:canc_app/users/patient/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class PatientBottomNavBar extends StatefulWidget {
  const PatientBottomNavBar({super.key});

  @override
  State<PatientBottomNavBar> createState() => _PatientBottomNavBarState();
}

class _PatientBottomNavBarState extends State<PatientBottomNavBar> {
  late PersistentTabController _controller;

  // Constants
  static const double _iconSize = 43.0;
  static const double _navBarHeight = 80.0;
  static const double _topPadding = 8.0;
  static const double _bottomPadding = 4.0;

  // Pages to display in the navigation bar
  final List<Widget> _pages = [
    const HomeView(),
    const ChatsListView(),
    const CommunityPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _pages,
        items: _buildNavBarItems(),
        resizeToAvoidBottomInset: true,
        onItemSelected: (index) {
          /// keyboard focus false when item is selected (for chat view search field)
          FocusScope.of(context).unfocus();
        },
        padding: EdgeInsets.only(
          top: context.setSp(_topPadding),
          bottom: context.setSp(_bottomPadding),
        ),
        navBarHeight: context.setSp(_navBarHeight),
        animationSettings: _buildAnimationSettings(),
        navBarStyle: NavBarStyle.simple,
      ),
    );
  }

  // Create navigation bar items
  List<PersistentBottomNavBarItem> _buildNavBarItems() {
    return [
      _buildNavBarItem(
        activeIcon: IconlyBold.home,
        inactiveIcon: IconlyLight.home,
        title: S.of(context).home,
      ),
      _buildNavBarItem(
        activeIcon: IconlyBold.chat,
        inactiveIcon: IconlyLight.chat,
        title: S.of(context).chats,
      ),
      _buildNavBarItem(
        activeIcon: IconlyBold.user_3,
        inactiveIcon: IconlyLight.user_1,
        title: S.of(context).community,
      ),
      _buildNavBarItem(
        activeIcon: IconlyBold.profile,
        inactiveIcon: IconlyLight.profile,
        title: S.of(context).profile,
      ),
    ];
  }

  // Helper method to create a navigation bar item
  PersistentBottomNavBarItem _buildNavBarItem({
    required IconData activeIcon,
    required IconData inactiveIcon,
    required String title,
  }) {
    return PersistentBottomNavBarItem(
      icon: Icon(activeIcon),
      inactiveIcon: Icon(inactiveIcon),
      iconSize: context.setSp(_iconSize),
      title: title,
      activeColorPrimary: AppColors.primaryColor,
      inactiveColorPrimary: AppColors.mediumGray,
      textStyle: AppTextStyle.font15Bold(context),
    );
  }

  // Build the navigation bar animation settings
  NavBarAnimationSettings _buildAnimationSettings() {
    return const NavBarAnimationSettings(
      navBarItemAnimation: ItemAnimationSettings(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimationSettings(
        animateTabTransition: true,
        duration: Duration(milliseconds: 300),
        screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
      ),
    );
  }
}

/// page for the community
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

/// page for the profile
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
