library;

import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/widgets/background_controller.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/widgets/background_final_button.dart';
import 'package:canc_app/core/shared_feature/onboarding/presentation/widgets/onboarding_navigation_bar.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'background_body.dart';

export 'background_final_button.dart';

class OnBoardingSlider extends StatefulWidget {
  /// Number of total pages.
  final int totalPage;

  /// NavigationBars color.
  final Color headerBackgroundColor;

  /// Background Color of whole screen apart from the NavigationBar.
  final Color? pageBackgroundColor;

  /// Background Gradient of whole screen apart from the NavigationBar.
  final Gradient? pageBackgroundGradient;

  /// Callback to be executed when clicked on the [finishButton].
  final Function? onFinish;

  /// NavigationBar trailing widget when on last screen.
  final Widget? trailing;

  /// NavigationBar trailing widget when not on last screen.
  final Widget? skipTextButton;

  /// The main content ont the screen displayed above the [background].
  final List<Widget> pageBodies;

  /// Callback to be executed when clicked on the last pages bottom button.
  final Function? trailingFunction;

  /// Style of the bottom button on the last page.
  final FinishButtonStyle? finishButtonStyle;

  /// Text inside last pages bottom button.
  final String? finishButtonText;

  /// Text style for text inside last pages bottom button.
  final TextStyle finishButtonTextStyle;

  /// Color of the bottom page indicators.
  final Color? controllerColor;

  /// Toggle bottom button.
  final bool addButton;

  /// Toggle bottom page controller visibilty.
  final bool addController;

  /// Whether has the floating action button to skip and the finish button
  final bool hasFloatingButton;

  /// Whether has the skip button in the bottom;
  final bool hasSkip;

  /// icon on the skip button
  final Icon skipIcon;

  /// is the indicator located on top of the screen
  final bool indicatorAbove;

  /// distance of indicator from bottom
  final double indicatorPosition;

  /// override the function for kip button in the navigator.
  final Function? skipFunctionOverride;

  /// back buttom text
  final String backButtonText;

  const OnBoardingSlider({
    super.key,
    required this.totalPage,
    required this.headerBackgroundColor,
    required this.pageBodies,
    this.onFinish,
    this.trailingFunction,
    this.trailing,
    this.skipTextButton,
    this.pageBackgroundColor,
    this.pageBackgroundGradient,
    this.finishButtonStyle,
    this.finishButtonText,
    this.controllerColor,
    this.addController = true,
    this.addButton = true,
    this.hasFloatingButton = true,
    this.hasSkip = true,
    this.finishButtonTextStyle = const TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
    this.skipIcon = const Icon(
      Icons.arrow_forward,
      color: Colors.white,
    ),
    this.indicatorAbove = false,
    this.indicatorPosition = 90,
    this.skipFunctionOverride,
    required this.backButtonText,
  });

  @override
  State<OnBoardingSlider> createState() => _OnBoardingSliderState();
}

class _OnBoardingSliderState extends State<OnBoardingSlider> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: widget.pageBackgroundColor,
        ),
      ),
      backgroundColor: widget.pageBackgroundColor,
      floatingActionButton: widget.hasFloatingButton
          ? Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Positions buttons correctly
              children: [
                (_currentPage > 0 && widget.totalPage - 1 > _currentPage)
                    ? // Show Back only if not on first page
                    Container(
                        margin: EdgeInsets.only(
                          left: isArabic() ? 0 : 35,
                          right: isArabic() ? 35 : 0,
                        ),
                        width: context.setWidth(108),
                        decoration: BoxDecoration(
                            color: AppColors.offWhite, // Background color
                            borderRadius:
                                BorderRadius.circular(10), // Adjust if needed
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: 0.05,
                                ), // Shadow color with 5% opacity
                                blurRadius: 5, // Blur strength
                                spreadRadius: 0, // Spread
                                offset: const Offset(0, 0), // No offset
                              ),
                            ]),
                        child: FloatingActionButton.extended(
                          onPressed: _onBack,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shape: widget.finishButtonStyle?.shape,
                          label: Text(
                            widget.backButtonText,
                            style: AppTextStyle.font20RegularDarkGray(context),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Flexible(
                  fit: FlexFit.loose,
                  child: BackgroundFinalButton(
                    buttonTextStyle: widget.finishButtonTextStyle,
                    skipIcon: widget.skipIcon,
                    addButton: widget.addButton,
                    currentPage: _currentPage,
                    pageController: _pageController,
                    totalPage: widget.totalPage,
                    onPageFinish: widget.onFinish,
                    finishButtonStyle: widget.finishButtonStyle,
                    buttonText: widget.finishButtonText,
                    hasSkip: widget.hasSkip,
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
      body: CupertinoPageScaffold(
        navigationBar: OnBoardingNavigationBar(
          skipFunctionOverride: widget.skipFunctionOverride,
          totalPage: widget.totalPage,
          currentPage: _currentPage,
          onSkip: _onSkip,
          headerBackgroundColor: widget.headerBackgroundColor,
          onFinish: widget.trailingFunction,
          finishButton: widget.trailing,
          skipTextButton: widget.skipTextButton,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: widget.pageBackgroundGradient,
            color: widget.pageBackgroundColor,
          ),
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: BackgroundBody(
                      controller: _pageController,
                      function: slide,
                      totalPage: widget.totalPage,
                      bodies: widget.pageBodies,
                    ),
                  ),
                  widget.addController
                      ? BackgroundController(
                          hasFloatingButton: widget.hasFloatingButton,
                          indicatorPosition: widget.indicatorPosition,
                          indicatorAbove: widget.indicatorAbove,
                          currentPage: _currentPage,
                          totalPage: widget.totalPage,
                          controllerColor: widget.controllerColor,
                        )
                      : const SizedBox.shrink(),
                ]),
          ),
        ),
      ),
    );
  }

  /// Slide to Next Page.
  void slide(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  /// Go back to the previous page
  void _onBack() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      setState(() {
        _currentPage--;
      });
    }
  }

  /// Skip to last Slide.
  void _onSkip() {
    _pageController.jumpToPage(widget.totalPage - 1);
    setState(() {
      _currentPage = widget.totalPage - 1;
    });
  }
}
