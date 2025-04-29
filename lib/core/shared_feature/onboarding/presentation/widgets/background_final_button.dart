import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:flutter/material.dart';

class FinishButtonStyle {
  final ShapeBorder? shape;

  final double? elevation;
  final double? focusElevation;
  final double? hoverElevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;

  const FinishButtonStyle({
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
    this.elevation = 0,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
  });
}

class BackgroundFinalButton extends StatelessWidget {
  final int currentPage;
  final PageController pageController;
  final int totalPage;
  final bool addButton;
  final Function? onPageFinish;
  final TextStyle buttonTextStyle;
  final String? buttonText;
  final bool hasSkip;
  final Icon skipIcon;
  final FinishButtonStyle? finishButtonStyle;

  const BackgroundFinalButton({
    super.key,
    required this.currentPage,
    required this.pageController,
    required this.totalPage,
    this.onPageFinish,
    this.buttonText,
    required this.buttonTextStyle,
    required this.addButton,
    required this.hasSkip,
    required this.skipIcon,
    this.finishButtonStyle = const FinishButtonStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return addButton
        ? hasSkip
            ? AnimatedContainer(
                width: currentPage == totalPage - 1
                    ? MediaQuery.of(context).size.width - context.setWidth(40)
                    : context.setWidth(108),
                duration: const Duration(milliseconds: 100),
                child: currentPage == totalPage - 1
                    ? FloatingActionButton.extended(
                        shape: finishButtonStyle?.shape,
                        elevation: finishButtonStyle?.elevation,
                        focusElevation: finishButtonStyle?.focusElevation,
                        hoverElevation: finishButtonStyle?.hoverElevation,
                        highlightElevation:
                            finishButtonStyle?.highlightElevation,
                        disabledElevation: finishButtonStyle?.disabledElevation,
                        foregroundColor: finishButtonStyle?.foregroundColor,
                        backgroundColor: finishButtonStyle?.backgroundColor,
                        focusColor: finishButtonStyle?.focusColor,
                        hoverColor: finishButtonStyle?.hoverColor,
                        splashColor: finishButtonStyle?.splashColor,
                        onPressed: () => onPageFinish?.call(),
                        label: buttonText == null
                            ? const SizedBox.shrink()
                            : Text(
                                buttonText!,
                                style: buttonTextStyle,
                              ),
                      )
                    : FloatingActionButton.extended(
                        shape: finishButtonStyle?.shape,
                        elevation: finishButtonStyle?.elevation,
                        backgroundColor: finishButtonStyle?.backgroundColor,
                        onPressed: () => _goToNextPage(context),
                        label: Text(
                          buttonText ?? '',
                          style: buttonTextStyle,
                        ),
                      ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(context).size.width - context.setWidth(40),
                child: FloatingActionButton.extended(
                  shape: finishButtonStyle?.shape,
                  elevation: finishButtonStyle?.elevation,
                  focusElevation: finishButtonStyle?.focusElevation,
                  hoverElevation: finishButtonStyle?.hoverElevation,
                  highlightElevation: finishButtonStyle?.highlightElevation,
                  disabledElevation: finishButtonStyle?.disabledElevation,
                  foregroundColor: finishButtonStyle?.foregroundColor,
                  backgroundColor: finishButtonStyle?.backgroundColor,
                  focusColor: finishButtonStyle?.focusColor,
                  hoverColor: finishButtonStyle?.hoverColor,
                  splashColor: finishButtonStyle?.splashColor,
                  onPressed: () => onPageFinish?.call(),
                  label: buttonText == null
                      ? const SizedBox.shrink()
                      : Text(
                          buttonText!,
                          style: buttonTextStyle,
                        ),
                ),
              )
        : const SizedBox.shrink();
  }

  /// Switch to Next Slide using the Floating Action Button.
  void _goToNextPage(BuildContext context) {
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
