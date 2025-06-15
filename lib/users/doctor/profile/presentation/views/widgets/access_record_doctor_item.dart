import 'package:canc_app/core/theming/app_styles.dart';
import 'package:canc_app/users/doctor/profile/data/model/record_doctor_model.dart';
import 'package:flutter/material.dart';

/// Individual record item widget
class AccessRecordDoctorItem extends StatelessWidget {
  const AccessRecordDoctorItem({
    super.key,
    required this.record,
  });

  final RecordDoctorModel record;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height * 0.22,
      child: Stack(
        children: [
          _buildMainContainer(context, height, width),
          _buildDateIndicator(context),
        ],
      ),
    );
  }

  Widget _buildMainContainer(
      BuildContext context, double height, double width) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Row(
          children: [
            if (record.imageUrl != null) _buildImageContainer(height, width),
            SizedBox(width: width * 0.05),
            _buildNoteText(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer(double height, double width) {
    return record.imageUrl != null
        ? Container(
            height: height * 0.2,
            width: width * 0.38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(record.imageUrl!),
                fit: BoxFit.fill,
              ),
            ),
          )
        : const SizedBox();
  }

  Widget _buildNoteText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          record.note,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.font12MediumDarkGray(context),
        ),
      ),
    );
  }

  Widget _buildDateIndicator(BuildContext context) {
    return Positioned(
      bottom: 8,
      right: 10,
      child: Text(
        record.date,
        style: AppTextStyle.font12MediumDarkGray(context),
      ),
    );
  }
}
