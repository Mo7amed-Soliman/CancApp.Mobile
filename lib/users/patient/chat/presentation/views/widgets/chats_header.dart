import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/chat/presentation/views/widgets/search_chats_button.dart';
import 'package:canc_app/users/patient/chat/presentation/views/widgets/search_field_chats.dart';
import 'package:flutter/material.dart';

class ChatsHeader extends StatefulWidget {
  const ChatsHeader({super.key});

  @override
  State<ChatsHeader> createState() => _ChatsHeaderState();
}

class _ChatsHeaderState extends State<ChatsHeader>
    with SingleTickerProviderStateMixin {
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    if (!mounted) return;

    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (_isSearchVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: context.setMinSize(16),
      ),
      height: context.screenHeight * 0.112,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!_isSearchVisible)
            Text(
              S.of(context).cancApp,
              style: AppTextStyle.font28RighteousPrimary(context).copyWith(
                color: AppColors.offWhite,
                height: 1.86,
              ),
            )
          else
            SearchFieldChats(
              controller: _searchController,
              slideAnimation: _slideAnimation,
            ),
          const HorizontalSpacer(10),
          SearchChatsButton(
            isSearchVisible: _isSearchVisible,
            onTap: _toggleSearch,
          ),
        ],
      ),
    );
  }
}
