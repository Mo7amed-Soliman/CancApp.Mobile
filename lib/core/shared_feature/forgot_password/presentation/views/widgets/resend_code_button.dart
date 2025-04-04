import 'package:canc_app/core/widgets/auth_prompt_button.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ResendCodeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ResendCodeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AuthPromptButton(
        promptText: S.of(context).didNotReceiveCode,
        actionText: S.of(context).sendAgain,
        onPressed: onPressed,
      ),
    );
  }
}
