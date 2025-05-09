import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final int currentPage;
  final Function onSkip;
  final int totalPage;
  final Function? onFinish;
  final Widget? finishButton;
  final Widget? skipTextButton;
  final Color headerBackgroundColor;
  final Function? skipFunctionOverride;

  const OnBoardingNavigationBar({
    super.key,
    required this.currentPage,
    required this.onSkip,
    required this.headerBackgroundColor,
    required this.totalPage,
    this.onFinish,
    this.finishButton,
    this.skipTextButton,
    this.skipFunctionOverride,
  });

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (hideNavigationBar) return const SizedBox.shrink();
    return CupertinoNavigationBar(
      automaticallyImplyLeading: false,
      trailing: currentPage == totalPage - 1
          ? finishButton == null
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.transparent,
                  child: TextButton(
                    onPressed: () => onFinish?.call(),
                    child: finishButton!,
                  ),
                )
          : skipTextButton == null
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.transparent,
                  child: TextButton(
                    onPressed: () {
                      if (skipFunctionOverride == null) {
                        onSkip();
                      } else {
                        skipFunctionOverride!();
                      }
                    },
                    child: skipTextButton!,
                  ),
                ),
      border: const Border(
        bottom: BorderSide(color: Colors.transparent),
      ),
      backgroundColor: headerBackgroundColor,
    );
  }

  bool get hideNavigationBar {
    if (currentPage == totalPage - 1) {
      return finishButton == null;
    }
    return skipTextButton == null;
  }
}
