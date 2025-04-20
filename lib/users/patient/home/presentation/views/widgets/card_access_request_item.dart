import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/widgets/horizontal_spacer.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:canc_app/users/patient/home/presentation/views/widgets/buttom_request_item.dart';
import 'package:flutter/material.dart';

class AccessRequestItem {
  final String id;
  final String image;
  final String name;
  final String message;

  const AccessRequestItem({
    required this.id,
    required this.image,
    required this.name,
    required this.message,
  });
}

class CardAccessRequestItem extends StatelessWidget {
  const CardAccessRequestItem({
    super.key,
    required this.item,
    required this.onAllow,
    required this.onDeny,
  });

  final AccessRequestItem item;
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
            Image.asset(
              item.image,
              height: context.setMinSize(75),
              width: context.setMinSize(75),
              fit: BoxFit.fill,
            ),
            const HorizontalSpacer(18),
            SizedBox(
              width: context.screenWidth * 0.41,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.01,
                  ),
                  Text(
                    item.message,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
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
