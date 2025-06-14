import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/community_view.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/doctor/chat/presentation/views/doctor_chat_view.dart';
import 'package:canc_app/users/doctor/profile/presentation/views/profile_doctor_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class DoctorBottomNavBar extends StatefulWidget {
  const DoctorBottomNavBar({super.key});

  @override
  State<DoctorBottomNavBar> createState() => _DoctorBottomNavBarState();
}

class _DoctorBottomNavBarState extends State<DoctorBottomNavBar> {
  late PersistentTabController _controller;

  // Constants
  static const double _iconSize = 40.0;
  static const double _navBarHeight = 80.0;
  static const double _topPadding = 8.0;
  static const double _bottomPadding = 4.0;

  // Pages to display in the navigation bar
  final List<Widget> _pages = [
    Container(),
    const DoctorChatView(),
    const CommunityView(),
    const ProfileDoctorView(),
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
        handleAndroidBackButtonPress: false,
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
        activeIcon: Icons.auto_awesome,
        inactiveIcon: Icons.auto_awesome_outlined,
        title: S.of(context).ai,
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
