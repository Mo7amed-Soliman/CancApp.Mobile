import 'package:canc_app/core/widgets/custom_text_field.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class SearchFieldChats extends StatelessWidget {
  final TextEditingController controller;
  final Animation<Offset> slideAnimation;

  const SearchFieldChats({
    super.key,
    required this.controller,
    required this.slideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SlideTransition(
        position: slideAnimation,
        child: CustomTextField(
          controller: controller,
          hintText: S.of(context).search,
        ),
      ),
    );
  }
}
