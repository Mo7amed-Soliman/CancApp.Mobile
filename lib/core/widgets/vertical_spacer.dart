import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:flutter/material.dart';

class VerticalSpacer extends StatelessWidget {
  final double height;

  const VerticalSpacer(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: context.setHeight(height));
  }
}
