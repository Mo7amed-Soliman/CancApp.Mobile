import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class AddDateSection extends StatelessWidget {
  const AddDateSection({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date = DateFormat('dd-MM-yyyy').format(now);
    return Container(
      color: Colors.white60,
      height: 120,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                S.of(context).addDate,
                style: AppTextStyle.font20SemiBold(context),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Icon(
                  IconlyLight.calendar,
                  size: 25,
                ),
                const SizedBox(
                  width: 100,
                ),
                Text(
                  date,
                  style: AppTextStyle.font18SemiBoldDarkGray(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
