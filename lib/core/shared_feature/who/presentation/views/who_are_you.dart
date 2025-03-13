import 'package:canc_app/core/shared_feature/who/presentation/widgets/user_role_selection_widget.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/widgets/app_buttom_widget.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class WhoAreYou extends StatefulWidget {
  const WhoAreYou({super.key});

  @override
  State<WhoAreYou> createState() => _WhoAreYouState();
}

class _WhoAreYouState extends State<WhoAreYou> {
  String selectedRoleKey = 'doctor'; // Default role key
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColors.offWhite,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: UserRoleSelectionWidget(
              selectedRoleKey: selectedRoleKey,
              onRoleSelected: (key) => setState(() => selectedRoleKey = key),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: AppButtonWidget(
              onPressed: () {},
              text: S.of(context).next,
            ),
          )
        ],
      ),
    );
  }
}
