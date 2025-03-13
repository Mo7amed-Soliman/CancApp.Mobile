import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(30),
            ),
            child: SizedBox(
              width: context.sizeProvider.width,
              height: context.sizeProvider.height * 0.58,
              child: SvgPicture.asset(image),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.font24SemiBoldDarkGray(context),
          ),
          SizedBox(height: context.setHeight(5)),
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyle.font16MediumDarkGray(context),
          ),
        ],
      ),
    );
  }
}
