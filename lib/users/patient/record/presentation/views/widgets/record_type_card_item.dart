import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

class RecordTypeCardItem extends StatelessWidget {
  const RecordTypeCardItem({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.195,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(image),
          colorFilter: const ColorFilter.mode(
            Color.fromRGBO(0, 0, 0, 0.3),
            BlendMode.darken,
          ),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: AppTextStyle.font24SemiBoldDarkGray(context).copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
