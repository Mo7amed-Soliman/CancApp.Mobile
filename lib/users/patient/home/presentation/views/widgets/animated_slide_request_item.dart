import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:flutter/material.dart';

class AnimatedSlideRequestItem extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const AnimatedSlideRequestItem({
    super.key,
    required this.child,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin:
                isArabic() ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
