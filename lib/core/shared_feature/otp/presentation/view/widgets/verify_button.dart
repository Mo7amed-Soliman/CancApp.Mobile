import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class VerifyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isInputFilled;
  final bool isLoading;

  const VerifyButton({
    super.key,
    required this.onPressed,
    this.isInputFilled = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppButtonWidget(
      onPressed: isInputFilled ? onPressed : null,
      text: S.of(context).verify,
      isLoading: isLoading,
    );
  }
}
