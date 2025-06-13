import 'package:canc_app/core/helpers/extension/time_ago_extension.dart';
import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/core/widgets/vertical_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/home/data/models/access_request_model.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/buttom_request_item.dart';
import 'package:flutter/material.dart';

class CardAccessRequestItem extends StatelessWidget {
  const CardAccessRequestItem({
    super.key,
    required this.item,
    required this.onAllow,
    required this.onDeny,
  });

  final AccessRequestModel item;
  final VoidCallback onAllow;
  final VoidCallback onDeny;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.03,
        vertical: context.screenHeight * 0.004,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.03,
          vertical: context.screenHeight * 0.017,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: context.setMinSize(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.setMinSize(30)),
                child: Image.network(
                  item.doctorImage,
                  width: context.setMinSize(80),
                  height: context.setMinSize(80),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const HorizontalSpacer(18),
            SizedBox(
              width: context.screenWidth * 0.41,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.doctorName,
                    style: AppTextStyle.font18SemiBoldDarkGray(context),
                  ),
                  const VerticalSpacer(5),
                  Text(
                    item.requestedAt.timeAgo,
                    maxLines: 2,
                    style: AppTextStyle.font16RegularBlack(context),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: [
                ButtomRequestItem(
                  title: S.of(context).allow,
                  color: Colors.teal,
                  onPressed: onAllow,
                ),
                ButtomRequestItem(
                  title: S.of(context).deny,
                  color: Colors.red,
                  onPressed: onDeny,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
