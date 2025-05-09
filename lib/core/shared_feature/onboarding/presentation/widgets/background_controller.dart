import 'package:flutter/material.dart';

class BackgroundController extends StatelessWidget {
  final int currentPage;
  final int totalPage;
  final Color? controllerColor;
  final bool indicatorAbove;
  final double indicatorPosition;
  final bool hasFloatingButton;

  const BackgroundController({
    super.key,
    required this.currentPage,
    required this.totalPage,
    required this.controllerColor,
    required this.indicatorAbove,
    required this.hasFloatingButton,
    required this.indicatorPosition,
  });

  @override
  Widget build(BuildContext context) {
    return indicatorAbove
        ? (currentPage == totalPage - 1)
            ? const SizedBox.shrink()
            : Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(context),
                ),
              )
        : (currentPage == totalPage - 1) && hasFloatingButton
            ? const SizedBox.shrink()
            : Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(context),
                ),
              );
  }

  /// List of the slides Indicators.
  List<Widget> _buildPageIndicator(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < totalPage - 1; i++) {
      // -1 because the last page is the final button slection Role Selection View
      list.add(i == currentPage
          ? _indicator(true, context)
          : _indicator(false, context));
    }
    return list;
  }

  /// Slide Controller / Indicator.
  Widget _indicator(bool isActive, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: indicatorAbove ? indicatorPosition : 28,
      ),
      height: 8.0,
      width: isActive ? 16.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive
            ? controllerColor ?? Colors.white
            : (controllerColor ?? Colors.white).withValues(
                alpha: 0.25,
              ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}
