import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:flutter/material.dart';

class HorizontalSpacer extends StatelessWidget {
  final double width;

  const HorizontalSpacer(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: context.setWidth(width)); // Uses width extension
  }
}
