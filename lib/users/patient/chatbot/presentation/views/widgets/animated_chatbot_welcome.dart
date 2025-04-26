import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/helpers/utils/app_assets.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class AnimatedChatbotWelcome extends StatefulWidget {
  const AnimatedChatbotWelcome({super.key});

  @override
  State<AnimatedChatbotWelcome> createState() => _AnimatedChatbotWelcomeState();
}

class _AnimatedChatbotWelcomeState extends State<AnimatedChatbotWelcome>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: Center(
            child: Image.asset(
              AppAssets.botAvatar,
              height: context.setMinSize(200),
              width: context.setMinSize(200),
            ),
          ),
        ),
        Text(
          'Your AI assistant is ready to help.',
          style: AppTextStyle.font17Medium(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
