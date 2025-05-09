import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:canc_app/core/theming/app_colors.dart';
import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/core/widgets/edit_delete_popup_menu.dart';
import 'package:canc_app/users/patient/record/data/models/recotd_model.dart';
import 'package:flutter/material.dart';

class RecordDetailItem extends StatelessWidget {
  final RecordModel record;

  const RecordDetailItem({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    return SizedBox(
      height: context.setHeight(140),
      child: Stack(
        children: [
          // Background container with image and note
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primaryColor.withAlpha(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            height: context.setHeight(140),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                record.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image(
                          image: AssetImage(record.image!.path),
                          fit: BoxFit.cover,
                          width: width * 0.4,
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 8),
                // Note text
                Expanded(
                  child: Container(
                    height: context.setHeight(100),
                    padding: const EdgeInsets.only(right: 8.0, top: 6),
                    child: Text(
                      record.note,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.font14RegularDarkGray(context),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Popup menu (top-right)
          Positioned(
            top: 10,
            right: -12,
            child: EditDeletePopupMenu(
              onEdit: () {},
              onDelete: () {},
            ),
          ),

          // Date (bottom-right)
          Positioned(
            bottom: 14,
            right: 10,
            child: Text(
              record.date,
              style: AppTextStyle.font12MediumDarkGray(context),
            ),
          ),
        ],
      ),
    );
  }
}
